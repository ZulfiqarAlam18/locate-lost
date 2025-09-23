import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxController {
  static LocationService get instance => Get.find<LocationService>();
  
  // Observable variables
  var isLocationEnabled = false.obs;
  var hasLocationPermission = false.obs;
  var currentPosition = Rxn<Position>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    _checkInitialLocationStatus();
  }
  
  // Check initial location status
  Future<void> _checkInitialLocationStatus() async {
    try {
      isLocationEnabled.value = await Geolocator.isLocationServiceEnabled();
      final permission = await Geolocator.checkPermission();
      hasLocationPermission.value = permission == LocationPermission.always || 
                                   permission == LocationPermission.whileInUse;
    } catch (e) {
      print('Error checking location status: $e');
    }
  }
  
  // Check if location services are enabled
  Future<bool> checkLocationService() async {
    try {
      isLocationEnabled.value = await Geolocator.isLocationServiceEnabled();
      return isLocationEnabled.value;
    } catch (e) {
      errorMessage.value = 'Failed to check location service: $e';
      return false;
    }
  }
  
  // Check location permission
  Future<LocationPermission> checkLocationPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      hasLocationPermission.value = permission == LocationPermission.always || 
                                   permission == LocationPermission.whileInUse;
      return permission;
    } catch (e) {
      errorMessage.value = 'Failed to check location permission: $e';
      return LocationPermission.denied;
    }
  }
  
  // Request location permission
  Future<LocationPermission> requestLocationPermission() async {
    try {
      errorMessage.value = '';
      
      // First check if location services are enabled
      if (!await checkLocationService()) {
        errorMessage.value = 'Location services are disabled. Please enable them in device settings.';
        return LocationPermission.denied;
      }
      
      // Check current permission
      LocationPermission permission = await checkLocationPermission();
      
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
      }
      
      // Update permission status
      hasLocationPermission.value = permission == LocationPermission.always || 
                                   permission == LocationPermission.whileInUse;
      
      return permission;
    } catch (e) {
      errorMessage.value = 'Failed to request location permission: $e';
      return LocationPermission.denied;
    }
  }
  
  // Get current location
  Future<Position?> getCurrentLocation() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Check location permission first
      final permission = await requestLocationPermission();
      
      if (permission == LocationPermission.denied || 
          permission == LocationPermission.deniedForever) {
        errorMessage.value = 'Location permission denied';
        return null;
      }
      
      // Get location with timeout
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
        ),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Location request timeout. Please try again.');
        },
      );
      
      currentPosition.value = position;
      return position;
      
    } catch (e) {
      errorMessage.value = 'Failed to get location: $e';
      return null;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Open device location settings
  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
    } catch (e) {
      errorMessage.value = 'Failed to open location settings: $e';
    }
  }
  
  // Open app settings for permission
  Future<void> openAppSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      errorMessage.value = 'Failed to open app settings: $e';
    }
  }
  
  // Check if all location requirements are met
  bool get isLocationReady => isLocationEnabled.value && hasLocationPermission.value;
  
  // Get location permission status as human-readable string
  String getPermissionStatusText(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
        return 'Always allowed';
      case LocationPermission.whileInUse:
        return 'While using app';
      case LocationPermission.denied:
        return 'Denied';
      case LocationPermission.deniedForever:
        return 'Permanently denied';
      default:
        return 'Unknown';
    }
  }
  
  // Comprehensive location setup for login flow
  Future<LocationSetupResult> setupLocationForLogin() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Step 1: Check location services
      if (!await checkLocationService()) {
        return LocationSetupResult(
          success: false,
          message: 'Location services are disabled. Please enable them in device settings.',
          needsLocationService: true,
        );
      }
      
      // Step 2: Request permission
      final permission = await requestLocationPermission();
      
      if (permission == LocationPermission.denied) {
        return LocationSetupResult(
          success: false,
          message: 'Location permission is required to use this app.',
          needsPermission: true,
        );
      }
      
      if (permission == LocationPermission.deniedForever) {
        return LocationSetupResult(
          success: false,
          message: 'Location permission is permanently denied. Please enable it in app settings.',
          needsAppSettings: true,
        );
      }
      
      // Step 3: Get current location to verify everything works
      final position = await getCurrentLocation();
      
      if (position == null) {
        return LocationSetupResult(
          success: false,
          message: 'Unable to get location. Please try again.',
        );
      }
      
      return LocationSetupResult(
        success: true,
        message: 'Location services enabled successfully!',
        position: position,
      );
      
    } catch (e) {
      return LocationSetupResult(
        success: false,
        message: 'Location setup failed: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Monitor location permission changes
  void startLocationMonitoring() {
    // Check location status periodically
    ever(isLocationEnabled, (enabled) {
      if (!enabled) {
        Get.snackbar(
          'Location Disabled',
          'Location services have been disabled. Some features may not work properly.',
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    });
  }
}

// Result class for location setup
class LocationSetupResult {
  final bool success;
  final String message;
  final bool needsLocationService;
  final bool needsPermission;
  final bool needsAppSettings;
  final Position? position;
  
  LocationSetupResult({
    required this.success,
    required this.message,
    this.needsLocationService = false,
    this.needsPermission = false,
    this.needsAppSettings = false,
    this.position,
  });
}