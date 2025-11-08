import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:locate_lost/navigation/app_routes.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/views/widgets/main_bottom_navigation.dart';
import 'package:locate_lost/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  final bool isInNavigation;

  const HomeScreen({super.key, this.isInNavigation = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Get AuthController for dynamic user data
  AuthController get authController => Get.find<AuthController>();
  
  // Statistics variables (will be updated with real data later)
  int activeCases = 12;
  int resolvedCases = 48;
  int thisMonthCases = 8;
  
  late MainNavigationController navController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();

  // Recent cases data
  final List<Map<String, dynamic>> recentCases = [
    {
      'id': 'MP-001',
      'name': 'Emma Johnson',
      'age': 8,
      'type': 'missing',
      'status': 'Active',
      'location': 'Riverside Park',
      'date': '2 hours ago',
      'image': 'assets/images/ali.png',
      'priority': 'Critical',
    },
    {
      'id': 'FP-001',
      'name': 'Alex Wilson',
      'age': 12,
      'type': 'found',
      'status': 'Found',
      'location': 'Downtown Mall',
      'date': '5 hours ago',
      'image': 'assets/images/zulfiqar.png',
      'priority': 'High',
    },
    {
      'id': 'MP-002',
      'name': 'Sarah Davis',
      'age': 6,
      'type': 'missing',
      'status': 'Investigating',
      'location': 'Central School',
      'date': '1 day ago',
      'image': 'assets/images/bg.png',
      'priority': 'Medium',
    },
  ];

  @override
  void initState() {
    super.initState();

    // AuthController removed — UI-only mode (username shown as static)

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Initialize or get the navigation controller
    try {
      navController = Get.find<MainNavigationController>();
    } catch (e) {
      navController = Get.put(MainNavigationController());
    }

    if (!widget.isInNavigation) {
      navController.setIndex(0);
    }

    // Start animations
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Function to handle navigation from drawer
  void navigateToScreen(String routeName) {
    Navigator.pop(context); // Close the drawer
    Get.toNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: AppColors.primary,
                  size: 28.w,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.primary,
              size: 24.w,
            ),
            onPressed: () => Get.toNamed(AppRoutes.notifications),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: CustomScrollView(
              slivers: [
                // Welcome Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        _buildWelcomeSection(),
                        SizedBox(height: 16.h),
                        _buildSubtitleText(),
                        SizedBox(height: 32.h),
                        _buildSearchBar(),
                        SizedBox(height: 32.h),
                        _buildQuickActions(),
                        SizedBox(height: 32.h),
                        _buildRecentCasesHeader(),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
                // Recent Cases List
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _buildRecentCaseCard(recentCases[index], index),
                      childCount: recentCases.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100.h,
                  ), // Bottom padding for navigation
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(),


    

      // extendBody: !widget.isInNavigation,

      // bottomNavigationBar:
      //     widget.isInNavigation
      //         ? null
      //         : Obx(
      //           () => MainBottomNavigation(
      //             currentIndex: navController.selectedIndex.value,
      //             onTap: navController.changeIndex,
      //           ),
      //         ),


    );
  }

  // Welcome Section
  Widget _buildWelcomeSection() {
    return _buildModernWelcomeCard();
  }

  // Modern Welcome Card (inspired by the reference image)
  Widget _buildModernWelcomeCard() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info Section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Obx(() {
                          final userName = authController.userName.value.isNotEmpty 
                              ? authController.userName.value 
                              : 'User';
                          final profileImage = authController.userProfileImage.value;
                          
                          return CircleAvatar(
                            radius: 22.r,
                            backgroundColor: Colors.white,
                            backgroundImage: profileImage.isNotEmpty 
                                ? NetworkImage(profileImage) as ImageProvider
                                : const AssetImage('assets/images/ali.png'),
                            onBackgroundImageError: (exception, stackTrace) {},
                            child: profileImage.isEmpty ? Text(
                              userName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join(''),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ) : null,
                          );
                        }),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                              authController.userName.value.isNotEmpty 
                                  ? authController.userName.value 
                                  : 'User',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                            SizedBox(height: 2.h),
                            Obx(() => Text(
                              authController.userRole.value.isNotEmpty
                                  ? '${authController.userRole.value.toUpperCase()} User'
                                  : 'Community Safety Officer',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Welcome Message
                  Text(
                    'Good Morning,',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Welcome Back! 👋',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCardStat(activeCases.toString(), 'Active\nCases'),
                      _buildCardStat(resolvedCases.toString(), 'Resolved\nCases'),
                      _buildCardStat(thisMonthCases.toString(), 'This\nMonth'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  // Subtitle Text
  Widget _buildSubtitleText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Text(
        'Help reunite families and keep communities safe together',
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by name, ID, or location...',
          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 20.w,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }

  // Quick Action Cards
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Report Missing',
                subtitle: 'Child',
                icon: Icons.person_search_rounded,
                gradient: LinearGradient(
                  colors: [AppColors.error, AppColors.error.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () => Get.toNamed(AppRoutes.missingPersonDetails),

               // onTap: () => Get.toNamed(AppRoutes.parentCaseSummary),

              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildActionCard(
                title: 'Report Found',
                subtitle: 'Child',
                icon: Icons.person_pin_rounded,
                gradient: LinearGradient(
                  colors: [
                    AppColors.success,
                    AppColors.success.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              //  onTap: () => Get.toNamed(AppRoutes.cameraCapture),


                onTap: (){

                   _showImageOptionsDialog();

                }

              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: title,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: Colors.white, size: 24.w),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Recent Cases Header
  Widget _buildRecentCasesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Cases',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () => Get.toNamed(AppRoutes.myCases),
          child: Text(
            'View All',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Recent Case Card
  Widget _buildRecentCaseCard(Map<String, dynamic> caseData, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      caseData['image'],
                      width: 60.w,
                      height: 60.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.person,
                            color: AppColors.textMuted,
                            size: 30.w,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              caseData['name'],
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            _buildStatusChip(caseData['status']),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Age ${caseData['age']} • ${caseData['location']}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          caseData['date'],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.textMuted,
                    size: 16.w,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    Color backgroundColor;

    switch (status.toLowerCase()) {
      case 'active':
        color = AppColors.error;
        backgroundColor = AppColors.error.withOpacity(0.1);
        break;
      case 'found':
        color = AppColors.success;
        backgroundColor = AppColors.success.withOpacity(0.1);
        break;
      case 'investigating':
        color = AppColors.warning;
        backgroundColor = AppColors.warning.withOpacity(0.1);
        break;
      default:
        color = AppColors.textSecondary;
        backgroundColor = AppColors.surfaceVariant;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // Drawer
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(bottom: 20.h),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final userName = authController.userName.value.isNotEmpty 
                        ? authController.userName.value 
                        : 'User';
                    final profileImage = authController.userProfileImage.value;
                    
                    return CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white,
                      backgroundImage: profileImage.isNotEmpty 
                          ? NetworkImage(profileImage) as ImageProvider
                          : null,
                      child: profileImage.isEmpty ? Text(
                        userName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join(''),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ) : null,
                    );
                  }),
                  SizedBox(height: 12.h),
                  Obx(() => Text(
                    authController.userName.value.isNotEmpty 
                        ? authController.userName.value 
                        : 'User',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                  Obx(() => Text(
                    authController.userEmail.value.isNotEmpty
                        ? authController.userEmail.value
                        : 'user@example.com',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  )),
                ],
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home_rounded,
              title: 'Home',
              onTap: () => navigateToScreen(AppRoutes.home),
            ),
            _buildDrawerItem(
              icon: Icons.person_rounded,
              title: 'Profile',
              onTap: () => navigateToScreen(AppRoutes.profile),
            ),
            _buildDrawerItem(
              icon: Icons.settings_rounded,
              title: 'Settings',
              onTap: () => navigateToScreen(AppRoutes.settings),
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart_rounded,
              title: 'Statistics',
              onTap: () => navigateToScreen(AppRoutes.stats),
            ),
            const Divider(),
            _buildDrawerItem(
              icon: Icons.help_outline_rounded,
              title: 'FAQs',
              onTap: () => navigateToScreen(AppRoutes.faqs),
            ),
            _buildDrawerItem(
              icon: Icons.info_outline_rounded,
              title: 'About Us',
              onTap: () => navigateToScreen(AppRoutes.aboutUs),
            ),
            _buildDrawerItem(
              icon: Icons.phone_rounded,
              title: 'Contact Us',
              onTap: () => navigateToScreen(AppRoutes.contactUs),
            ),
            const Divider(),
            _buildDrawerItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Terms & Conditions',
              onTap: () => navigateToScreen(AppRoutes.termsAndConditions),
            ),
            _buildDrawerItem(
              icon: Icons.logout_rounded,
              title: 'Log Out',
              onTap: () async {
                Navigator.pop(context);
                
                // Show confirmation dialog
                final confirmed = await Get.dialog<bool>(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    title: Text(
                      'Confirm Logout',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to logout?',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Get.back(result: true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                
                // If user confirmed logout
                if (confirmed == true) {
                  // Get AuthController and logout
                  final authController = Get.find<AuthController>();
                  await authController.logout();
                  
                  // Navigate to login screen and clear all previous routes
                  Get.offAllNamed(AppRoutes.login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    );
  }

// Show popup dialog for image options
  void _showImageOptionsDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                'Select Image Option',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'How would you like to provide images of the found person?',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              // Capture Images Option
              _buildImageOption(
                icon: Icons.camera_alt,
                title: 'Capture Images',
                subtitle: 'Take photos using camera',
                onTap: () {
                  Get.back(); // Close dialog
                  Get.toNamed(AppRoutes.cameraCapture);
                },
              ),
              
              SizedBox(height: 16.h),

              // Upload from Gallery Option
              _buildImageOption(
                icon: Icons.photo_library,
                title: 'Upload from Gallery',
                subtitle: 'Select images from gallery',
                onTap: () {
                  Get.back(); // Close dialog
                  Get.toNamed(AppRoutes.finderUploadImages);
                },
              ),

              SizedBox(height: 20.h),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

 Widget _buildImageOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.secondary.withOpacity(0.1),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
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
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
