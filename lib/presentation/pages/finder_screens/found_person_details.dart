import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/core/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/presentation/widgets/custom_elevated_button.dart';
import 'package:locate_lost/presentation/widgets/custom_text_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FoundPersonDetailsScreen extends StatefulWidget {
  const FoundPersonDetailsScreen({super.key});

  @override
  State<FoundPersonDetailsScreen> createState() =>
      _FoundPersonDetailsScreenState();
}

class _FoundPersonDetailsScreenState extends State<FoundPersonDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Organized controllers map for better management
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'fatherName': TextEditingController(),
    'foundPlace': TextEditingController(),
    'foundDate': TextEditingController(),
    'foundTime': TextEditingController(),
    'finderPhone': TextEditingController(),
    'finderSecondaryPhone': TextEditingController(),
    'additionalDetails': TextEditingController(),
  };

  String? selectedGender;

  // Dynamic progress tracking
  double get progressPercent => _calculateProgress();
  
  // Calculate progress based on completed fields (0% to 90% for this screen)
  double _calculateProgress() {
    const maxProgress = 0.90; // This screen can complete up to 90% of total progress
    
    // Required fields for progress calculation
    List<bool> requiredFieldsCompleted = [
      _controllers['name']!.text.isNotEmpty,
      _controllers['fatherName']!.text.isNotEmpty,
      selectedGender != null && selectedGender!.isNotEmpty,
      _controllers['foundPlace']!.text.isNotEmpty,
      _controllers['foundDate']!.text.isNotEmpty,
      _controllers['foundTime']!.text.isNotEmpty,
      _controllers['finderPhone']!.text.isNotEmpty && 
        _validatePhone(_controllers['finderPhone']!.text),
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

  // Get dynamic progress text based on completion
  String _getProgressText() {
    int totalRequiredFields = 7;
    int completedFields = 0;
    
    // Count completed required fields
    if (_controllers['name']!.text.isNotEmpty) completedFields++;
    if (_controllers['fatherName']!.text.isNotEmpty) completedFields++;
    if (selectedGender != null && selectedGender!.isNotEmpty) completedFields++;
    if (_controllers['foundPlace']!.text.isNotEmpty) completedFields++;
    if (_controllers['foundDate']!.text.isNotEmpty) completedFields++;
    if (_controllers['foundTime']!.text.isNotEmpty) completedFields++;
    if (_controllers['finderPhone']!.text.isNotEmpty && _validatePhone(_controllers['finderPhone']!.text)) completedFields++;
    
    return '$completedFields of $totalRequiredFields required fields completed';
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to required fields for dynamic progress updates
    _controllers['name']!.addListener(_updateProgress);
    _controllers['fatherName']!.addListener(_updateProgress);
    _controllers['foundPlace']!.addListener(_updateProgress);
    _controllers['foundDate']!.addListener(_updateProgress);
    _controllers['foundTime']!.addListener(_updateProgress);
    _controllers['finderPhone']!.addListener(_updateProgress);
  }

  @override
  void dispose() {
    // Remove listeners before disposing controllers
    _controllers['name']!.removeListener(_updateProgress);
    _controllers['fatherName']!.removeListener(_updateProgress);
    _controllers['foundPlace']!.removeListener(_updateProgress);
    _controllers['foundDate']!.removeListener(_updateProgress);
    _controllers['foundTime']!.removeListener(_updateProgress);
    _controllers['finderPhone']!.removeListener(_updateProgress);
    
    // Dispose all controllers to prevent memory leaks
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                'Found Person',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(
              color: AppColors.primary,
              indent: 100,
              endIndent: 100,
              thickness: 2,
            ),
            SizedBox(height: 20.h),
            Center(
              child: Container(
                width: 390.w,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary, width: 1.5.w),
                ),
                child: Card(
                  elevation: 6,
                  color: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
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
                              SizedBox(height: 6.h),
                              Text(
                                _getProgressText(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.myRedColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CircularPercentIndicator(
                            radius: 40.r,
                            lineWidth: 8.0.w,
                            percent: progressPercent,
                            animation: true,
                            animationDuration: 800,
                            progressColor: progressPercent >= 0.6 
                                ? AppColors.primary 
                                : progressPercent >= 0.3 
                                    ? Colors.orange 
                                    : AppColors.myRedColor,
                            backgroundColor: Colors.teal.shade100,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              "${(progressPercent * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: progressPercent >= 0.6 
                                    ? AppColors.primary 
                                    : progressPercent >= 0.3 
                                        ? Colors.orange 
                                        : AppColors.myRedColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
           
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        'Name',
                        'Enter found person\'s name (if known)',
                        'name',
                        false,
                      ),
                      _buildTextField(
                        'Father\'s Name',
                        'Enter found person\'s father\'s name (if known)',
                        'fatherName',
                        false,
                      ),
                      _buildGenderDropdown(),
                      _buildTextField(
                        'Place Where Found',
                        'Enter exact location where the person was found',
                        'foundPlace',
                        true,
                      ),
                      _buildDatePicker(),
                      _buildTimePicker(),
                      _buildPhoneField(
                        'Finder\'s Phone Number',
                        'Enter your contact number (e.g., 03001234567)',
                        'finderPhone',
                        true,
                      ),
                      _buildPhoneField(
                        'Secondary Contact (Optional)',
                        'Alternative contact number if primary is unreachable',
                        'finderSecondaryPhone',
                        false,
                      ),
                      _buildTextField(
                        'Additional Details (Optional)',
                        'Any other relevant information about the person or circumstances',
                        'additionalDetails',
                        false,
                      ),
                      SizedBox(height: 20.h),
                      Row(
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
                              if (_formKey.currentState!.validate()) {
                                Get.toNamed(AppRoutes.cameraCapture);
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                _updateProgress();
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

  Widget _buildDatePicker() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Date Found',
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
            hintText: 'Select date when person was found',
            controller: _controllers['foundDate']!,
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
                _controllers['foundDate']!.text = formattedDate;
                _updateProgress();
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
              text: 'Time Found',
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
            hintText: 'Select time when person was found',
            controller: _controllers['foundTime']!,
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
                _controllers['foundTime']!.text = formattedTime;
                _updateProgress();
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
}
