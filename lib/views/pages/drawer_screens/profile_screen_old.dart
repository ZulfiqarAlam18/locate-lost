import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/views/widgets/main_bottom_navigation.dart';

class ProfileScreen extends StatefulWidget {
  final bool isInNavigation;
  
  const ProfileScreen({super.key, this.isInNavigation = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late MainNavigationController navController;
  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Form controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State variables
  bool _isEditingProfile = false;
  bool _isChangingPassword = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Validation states
  String? _nameError;
  String? _phoneError;
  String? _currentPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  // User data
  String username = 'Zohaib Khoso';
  String email = 'zohaib.khoso@example.com';
  String phone = '+92 300 1234567';
  int activeCases = 3;
  String lastLogin = '2 hours ago';
  DateTime joinDate = DateTime(2024, 1, 15);

  @override
  void initState() {
    super.initState();
    
    if (widget.isInNavigation) {
      navController = Get.find<MainNavigationController>();
    }

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.elasticOut,
    ));

    // Initialize text controllers
    _nameController.text = username;
    _phoneController.text = phone;
    _emailController.text = email;

    // Start animations
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _buttonAnimationController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateName(String value) {
    setState(() {
      if (value.isEmpty) {
        _nameError = 'Name is required';
      } else if (value.length < 2) {
        _nameError = 'Name must be at least 2 characters';
      } else {
        _nameError = null;
      }
    });
  }

  void _validatePhone(String value) {
    setState(() {
      if (value.isEmpty) {
        _phoneError = 'Phone number is required';
      } else if (!RegExp(r'^\+?[\d\s-()]{10,}$').hasMatch(value)) {
        _phoneError = 'Please enter a valid phone number';
      } else {
        _phoneError = null;
      }
    });
  }

  void _validatePasswords() {
    setState(() {
      if (_currentPasswordController.text.isEmpty) {
        _currentPasswordError = 'Current password is required';
      } else {
        _currentPasswordError = null;
      }

      if (_newPasswordController.text.isEmpty) {
        _newPasswordError = 'New password is required';
      } else if (_newPasswordController.text.length < 6) {
        _newPasswordError = 'Password must be at least 6 characters';
      } else {
        _newPasswordError = null;
      }

      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Please confirm your password';
      } else if (_confirmPasswordController.text != _newPasswordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  Future<void> _saveProfile() async {
    _validateName(_nameController.text);
    _validatePhone(_phoneController.text);

    if (_nameError == null && _phoneError == null) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        username = _nameController.text;
        phone = _phoneController.text;
        _isEditingProfile = false;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
    }
  }

  Future<void> _changePassword() async {
    _validatePasswords();

    if (_currentPasswordError == null && 
        _newPasswordError == null && 
        _confirmPasswordError == null) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _isChangingPassword = false;
        _isLoading = false;
      });

      // Clear password fields
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password changed successfully'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Get.offAllNamed(AppRoutes.login);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: AppColors.background,
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  pinned: true,
                ),
                
                // Profile Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        
                        // Avatar Section
                        _buildAvatarSection(),
                        
                        SizedBox(height: 30.h),
                        
                        // User Info Section
                        _buildUserInfoSection(),
                        
                        SizedBox(height: 24.h),
                        
                        // Action Cards
                        _buildActionCards(),
                        
                        SizedBox(height: 24.h),
                        
                        // Account Summary
                        _buildAccountSummary(),
                        
                        SizedBox(height: 30.h),
                        
                        // Logout Button
                        _buildLogoutButton(),
                        
                        SizedBox(height: 100.h), // Bottom navigation space
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.isInNavigation
          ? MainBottomNavigation(
              currentIndex: 3,
              onTap: (index) {
                if (index != 3) {
                  // Navigate to other screens based on index
                  switch (index) {
                    case 0:
                      Get.offNamed(AppRoutes.home);
                      break;
                    case 1:
                      Get.offNamed(AppRoutes.reportCase);
                      break;
                    case 2:
                      Get.offNamed(AppRoutes.caseSummary);
                      break;
                  }
                }
              },
            )
          : null,
    );
  }

  Widget _buildAvatarSection() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.7 + (0.3 * value),
          child: Column(
            children: [
              Stack(
                children: [
                  // Avatar with gradient border
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withOpacity(0.7),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/zulfiqar.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[100],
                                child: Icon(
                                  Icons.person,
                                  size: 50.sp,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Edit overlay button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Handle edit avatar
                        _buttonAnimationController.forward().then((_) {
                          _buttonAnimationController.reverse();
                        });
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Avatar edit feature coming soon'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        );
                      },
                      child: AnimatedBuilder(
                        animation: _buttonAnimationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16.h),
              
              // Username
              Text(
                username,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              
              SizedBox(height: 4.h),
              
              // Email
              Text(
                email,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              if (!_isEditingProfile)
                IconButton(
                  onPressed: () {
                    setState(() => _isEditingProfile = true);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          if (_isEditingProfile) ...[
            // Edit Mode
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person,
              error: _nameError,
              onChanged: _validateName,
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone,
              error: _phoneError,
              onChanged: _validatePhone,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 12.w),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditingProfile = false;
                      _nameController.text = username;
                      _phoneController.text = phone;
                      _nameError = null;
                      _phoneError = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: AppColors.textSecondary,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            // View Mode
            _buildInfoRow(Icons.person, 'Name', username),
            SizedBox(height: 16.h),
            _buildInfoRow(Icons.email, 'Email', email),
            SizedBox(height: 16.h),
            _buildInfoRow(Icons.phone, 'Phone', phone),
          ],
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? error,
    Function(String)? onChanged,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: AppColors.primary),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
        if (error != null) ...[
          SizedBox(height: 4.h),
          Text(
            error,
            style: TextStyle(
              color: AppColors.error,
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCards() {
    return Column(
      children: [
        // Edit Profile Card
        _buildActionCard(
          title: 'Edit Profile',
          subtitle: 'Update your personal information',
          icon: Icons.person_outline,
          color: AppColors.primary,
          onTap: () {
            setState(() => _isEditingProfile = true);
          },
        ),
        
        SizedBox(height: 16.h),
        
        // Change Password Card
        _buildActionCard(
          title: 'Change Password',
          subtitle: 'Update your account security',
          icon: Icons.lock_outline,
          color: AppColors.accent,
          onTap: () {
            setState(() => _isChangingPassword = true);
          },
        ),
        
        // Password Change Modal
        if (_isChangingPassword) ...[
          SizedBox(height: 16.h),
          _buildPasswordChangeSection(),
        ],
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24.sp,
                    ),
                  ),
                  
                  SizedBox(width: 16.w),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.textSecondary,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordChangeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isChangingPassword = false;
                    _currentPasswordController.clear();
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                    _currentPasswordError = null;
                    _newPasswordError = null;
                    _confirmPasswordError = null;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.textSecondary,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          _buildTextField(
            controller: _currentPasswordController,
            label: 'Current Password',
            icon: Icons.lock,
            obscureText: _obscureCurrentPassword,
            error: _currentPasswordError,
            onChanged: (_) => _validatePasswords(),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => _obscureCurrentPassword = !_obscureCurrentPassword);
              },
              icon: Icon(
                _obscureCurrentPassword ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          SizedBox(height: 16.h),
          
          _buildTextField(
            controller: _newPasswordController,
            label: 'New Password',
            icon: Icons.lock_outline,
            obscureText: _obscureNewPassword,
            error: _newPasswordError,
            onChanged: (_) => _validatePasswords(),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => _obscureNewPassword = !_obscureNewPassword);
              },
              icon: Icon(
                _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          SizedBox(height: 16.h),
          
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirm New Password',
            icon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            error: _confirmPasswordError,
            onChanged: (_) => _validatePasswords(),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
              },
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          SizedBox(height: 20.h),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Update Password',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSummary() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Summary',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Active Cases',
                  activeCases.toString(),
                  Icons.cases_outlined,
                  AppColors.primary,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildSummaryItem(
                  'Last Login',
                  lastLogin,
                  Icons.access_time,
                  AppColors.accent,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          _buildSummaryItem(
            'Member Since',
            '${joinDate.day}/${joinDate.month}/${joinDate.year}',
            Icons.calendar_today,
            AppColors.success,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon,
    Color color, {
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * value),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // 🔷 Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // 🔷 White Card Section
          Positioned(
            top: 200.h,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 200.h,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
            ),
          ),

          // 🔷 Profile Picture
          // Positioned(
          //   top: 110.h,
          //   left: MediaQuery.of(context).size.width / 2 - 70.w,
          //   child: DottedBorder(
          //     borderType: BorderType.RRect,
          //     radius: Radius.circular(70.r),
          //     dashPattern: [8, 4],
          //     color: Colors.teal,
          //     strokeWidth: 2.w,
          //     child: Card(
          //       shape: CircleBorder(side: BorderSide(color: AppColors.primary)),
          //       elevation: 16,
          //       child: CircleAvatar(
          //         radius: 70.r,
          //         backgroundImage: AssetImage('assets/images/zulfi.png'),
          //       ),
          //     ),
          //   ),
          // ),

          // 🔷 Profile Name
          Positioned(
            top: 275.h,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Zulfiqar Alam',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // 🔷 Tiles (My Profile, Security, Settings)
          Positioned(
            top: 330.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              children: [
                _buildProfileTile(
                  title: 'My Profile',
                  icon: Icons.person,
                  onTap: () {
                    // TODO: Navigate to profile page
                  },
                ),
                _buildProfileTile(
                  title: 'Security Details',
                  icon: Icons.security,
                  onTap: () {
                    // TODO: Navigate to security details
                  },
                ),
                _buildProfileTile(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    // TODO: Navigate to settings
                  },
                ),
              ],
            ),
          ),

          // back icon
          Positioned(
            top: 60.h,
            left: 13.w,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                size: 40.sp,
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom method to create profile tiles to avoid redundancy
  Widget _buildProfileTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      onTap: onTap,
    );
  }
