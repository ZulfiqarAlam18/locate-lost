import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/views/widgets/custom_elevated_button.dart';
import 'package:locate_lost/views/widgets/custom_text_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MissingPersonDetailsScreen extends StatefulWidget {
  const MissingPersonDetailsScreen({Key? key}) : super(key: key);

  @override
  _MissingPersonDetailsScreenState createState() =>
      _MissingPersonDetailsScreenState();
}

class _MissingPersonDetailsScreenState
    extends State<MissingPersonDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Removed MissingPersonController dependency - this screen runs in UI-only mode.

  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'fatherName': TextEditingController(),
    'caste': TextEditingController(),
    'age': TextEditingController(),
    'height': TextEditingController(),
    'hairColor': TextEditingController(),
    'skinColor': TextEditingController(),
    'disability': TextEditingController(),
    'lastSeenPlace': TextEditingController(),
    'lastSeenDate': TextEditingController(),
    'lastSeenTime': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'secondPhoneNumber': TextEditingController(),
    'additionalDetails': TextEditingController(),
  };

  String? selectedGender;

  // Dynamic progress tracking
  double get progressPercent => _calculateProgress();
  
  // Base progress for this screen (20%) plus dynamic progress based on field completion
  double _calculateProgress() {
    const maxProgress = 0.80; // This screen can complete up to 80% of total progress
    
    // Required fields for progress calculation
    List<bool> requiredFieldsCompleted = [
      _controllers['name']!.text.isNotEmpty,
      _controllers['fatherName']!.text.isNotEmpty,
      selectedGender != null && selectedGender!.isNotEmpty,
      _controllers['lastSeenPlace']!.text.isNotEmpty,
      _controllers['lastSeenDate']!.text.isNotEmpty,
      _controllers['lastSeenTime']!.text.isNotEmpty,
      _controllers['phoneNumber']!.text.isNotEmpty && 
        _validatePhone(_controllers['phoneNumber']!.text),
    ];
    
    int completedFields = requiredFieldsCompleted.where((completed) => completed).length;
    double progress = (completedFields / requiredFieldsCompleted.length) * maxProgress;
    
    return progress;
  }
  
  // Helper method to validate phone number
  bool _validatePhone(String phone) {
    if (phone.isEmpty) return false;
    if (phone.length < 10 || phone.length > 11) return false;
    return RegExp(r'^(03|02|04|05)\d{8,9}$').hasMatch(phone);
  }
  
  // Method to trigger progress update
  void _updateProgress() {
    setState(() {
      // This will trigger a rebuild and recalculate progress
    });
  }

  @override
  void dispose() {
    // Remove listeners before disposing controllers
    _controllers['name']!.removeListener(_updateProgress);
    _controllers['fatherName']!.removeListener(_updateProgress);
    _controllers['lastSeenPlace']!.removeListener(_updateProgress);
    _controllers['lastSeenDate']!.removeListener(_updateProgress);
    _controllers['lastSeenTime']!.removeListener(_updateProgress);
    _controllers['phoneNumber']!.removeListener(_updateProgress);
    
    // Dispose all controllers to prevent memory leaks
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // No controller available in UI-only mode. Start with empty inputs here.
    // Add listeners to required fields for dynamic progress updates
    _controllers['name']!.addListener(_updateProgress);
    _controllers['fatherName']!.addListener(_updateProgress);
    _controllers['lastSeenPlace']!.addListener(_updateProgress);
    _controllers['lastSeenDate']!.addListener(_updateProgress);
    _controllers['lastSeenTime']!.addListener(_updateProgress);
    _controllers['phoneNumber']!.addListener(_updateProgress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildProgressCard(),
            _buildForm(),
           // _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 50.h),
        Center(
          child: Text(
            'Missing Person Details',
            style: TextStyle(
              fontSize: 26.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Divider(
          color: AppColors.primary,
          indent: 80.w,
          endIndent: 80.w,
          thickness: 2.h,
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      height: 140.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary, width: 1.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.h),
          child: Row(
            children: [_buildProgressText(), _buildProgressIndicator()],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressText() {
    int totalRequiredFields = 7; // Name, Father's Name, Gender, Place, Date, Time, Phone
    int completedFields = 0;
    
    // Count completed required fields
    if (_controllers['name']!.text.isNotEmpty) completedFields++;
    if (_controllers['fatherName']!.text.isNotEmpty) completedFields++;
    if (selectedGender != null && selectedGender!.isNotEmpty) completedFields++;
    if (_controllers['lastSeenPlace']!.text.isNotEmpty) completedFields++;
    if (_controllers['lastSeenDate']!.text.isNotEmpty) completedFields++;
    if (_controllers['lastSeenTime']!.text.isNotEmpty) completedFields++;
    if (_controllers['phoneNumber']!.text.isNotEmpty && _validatePhone(_controllers['phoneNumber']!.text)) completedFields++;
    
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Progress',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '$completedFields of $totalRequiredFields required fields completed',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.myRedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    double currentProgress = progressPercent;
    
    return Expanded(
      flex: 1,
      child: CircularPercentIndicator(
        radius: 45.r,
        lineWidth: 8.0.w,
        percent: currentProgress,
        animation: true,
        animationDuration: 800,
        progressColor: currentProgress >= 0.6 
            ? AppColors.primary 
            : currentProgress >= 0.3 
                ? Colors.orange 
                : AppColors.myRedColor,
        backgroundColor: Colors.grey.shade300,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          "${(currentProgress * 100).toInt()}%",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: currentProgress >= 0.6 
                ? AppColors.primary 
                : currentProgress >= 0.3 
                    ? Colors.orange 
                    : AppColors.myRedColor,
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // _buildSectionTitle(
                //   'Please complete the form with the accurate details of the missing person',
                // ),
                // SizedBox(height: 15.h),
                // _buildSectionTitle('Missing Person Details:', size: 18),
                // SizedBox(height: 10.h),

                ..._buildFormFields(),
                 SizedBox(height: 20.h),
                _buildNavigationButtons(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField('Name', 'Enter Missing Person\'s name', 'name', true),
      _buildTextField(
        'Father\'s Name',
        'Enter Missing Person\'s father\'s name',
        'fatherName',
        true,
      ),
      _buildGenderDropdown(),
      _buildTextField(
        'Place Last Seen',
        'Enter the location where the person was last seen',
        'lastSeenPlace',
        true,
      ),
      _buildDatePicker(),
      _buildTimePicker(),
      _buildPhoneField(
        'Primary Contact Number',
        'Enter primary contact number (e.g., 03001234567)',
        'phoneNumber',
        true,
      ),
      _buildPhoneField(
        'Secondary Contact (Optional)',
        'Alternative contact number if primary is unreachable',
        'secondPhoneNumber',
        false,
      ),
      _buildTextField(
        'Additional Information',
        'Any other relevant details that might help locate the person',
        'additionalDetails',
        false,
      ),
    ];
  }

  Widget _buildTextField(
    String label,
    String hint,
    String controllerKey,
    bool isRequired,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
           // labelText: label,
            hintText: hint,
            controller: _controllers[controllerKey]!,
            validator: (value) {
              if (isRequired && (value?.isEmpty ?? true)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField(
    String label,
    String hint,
    String controllerKey,
    bool isRequired,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            hintText: hint,
            controller: _controllers[controllerKey]!,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            validator: (value) {
              if (isRequired && (value?.isEmpty ?? true)) {
                return 'This field is required';
              }
              if (value != null && value.isNotEmpty) {
                if (value.length < 10 || value.length > 11) {
                  return 'Phone number must be 10-11 digits';
                }
                if (!RegExp(r'^(03|02|04|05)\d{8,9}$').hasMatch(value)) {
                  return 'Enter valid Pakistan phone number (e.g., 03001234567)';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Date Last Seen',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            hintText: 'Select date when person was last seen',
            controller: _controllers['lastSeenDate']!,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: AppColors.primary,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (pickedDate != null) {
                String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                _controllers['lastSeenDate']!.text = formattedDate;
                _updateProgress(); // Update progress when date is selected
              }
            },
            suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please select the date';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Time Last Seen',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            hintText: 'Select time when person was last seen',
            controller: _controllers['lastSeenTime']!,
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: AppColors.primary,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (pickedTime != null) {
                String formattedTime = pickedTime.format(context);
                _controllers['lastSeenTime']!.text = formattedTime;
                _updateProgress(); // Update progress when time is selected
              }
            },
            suffixIcon: Icon(Icons.access_time, color: AppColors.primary),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please select the time';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Gender',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonFormField<String>(
              value: selectedGender,
              hint: Text(
                'Select Gender',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                border: InputBorder.none,
              ),
              items: ['MALE', 'FEMALE', 'OTHER'].map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(
                    gender.toLowerCase().replaceFirst(gender[0], gender[0].toUpperCase()),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
                _updateProgress(); // Update progress when gender is selected
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a gender';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            height: 45.h,
            width: 130.w,
            fontSize: 15.sp,
            borderRadius: 10.r,
            label: 'Back',
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
            showBorder: true,
          ),
          CustomElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // UI-only: simulate saving form data locally (no controller/backend)
                Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
                Future.delayed(Duration(milliseconds: 700), () {
                  if (Get.isDialogOpen ?? false) Get.back();
                  Get.toNamed(AppRoutes.uploadImages);
                });
              } else {
                Get.snackbar(
                  'Form Incomplete',
                  'Please fill all required fields',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            height: 45.h,
            width: 130.w,
            fontSize: 15.sp,
            borderRadius: 10.r,
            label: 'Next',
          ),
        ],
      ),
    );
  }
}
