import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class AboutSettingsScreen extends StatefulWidget {
  const AboutSettingsScreen({super.key});

  @override
  State<AboutSettingsScreen> createState() => _AboutSettingsScreenState();
}

class _AboutSettingsScreenState extends State<AboutSettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _teamMembers = [
    {
      'name': 'Ali Hassan',
      'role': 'Lead Developer',
      'image': 'assets/images/ali.png',
      'bio': 'Passionate about creating solutions that help reunite families.',
    },
    {
      'name': 'Zulfiqar Ahmad',
      'role': 'UI/UX Designer',
      'image': 'assets/images/zulfi.png',
      'bio': 'Designing intuitive experiences for better user engagement.',
    },
  ];

  final List<Map<String, dynamic>> _features = [
    {
      'icon': Icons.search,
      'title': 'Smart Search',
      'description': 'AI-powered search to find missing persons quickly',
    },
    {
      'icon': Icons.location_on,
      'title': 'Real-time Location',
      'description': 'Live location tracking and geofencing capabilities',
    },
    {
      'icon': Icons.people,
      'title': 'Community Network',
      'description': 'Connect with volunteers and local authorities',
    },
    {
      'icon': Icons.security,
      'title': 'Secure & Private',
      'description': 'End-to-end encryption and privacy protection',
    },
    {
      'icon': Icons.notifications,
      'title': 'Smart Alerts',
      'description': 'Intelligent notifications and emergency broadcasts',
    },
    {
      'icon': Icons.analytics,
      'title': 'Data Analytics',
      'description': 'Advanced analytics to improve search success rates',
    },
  ];

  final List<Map<String, dynamic>> _technologies = [
    {'name': 'Flutter', 'logo': '🔷', 'description': 'Cross-platform mobile development'},
    {'name': 'Firebase', 'logo': '🔥', 'description': 'Backend services and real-time database'},
    {'name': 'Google Maps', 'logo': '🗺️', 'description': 'Location services and mapping'},
    {'name': 'Machine Learning', 'logo': '🤖', 'description': 'AI-powered search and matching'},
    {'name': 'WebRTC', 'logo': '📹', 'description': 'Real-time communication'},
    {'name': 'Cloud Functions', 'logo': '☁️', 'description': 'Serverless backend logic'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
            size: 20.sp,
          ),
        ),
        title: Text(
          'About LocateLost',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // App Info Section
                _buildAppInfoSection(),

                SizedBox(height: 24.h),

                // Mission Statement
                _buildMissionSection(),

                SizedBox(height: 24.h),

                // Key Features
                _buildFeaturesSection(),

                SizedBox(height: 24.h),

                // Team Section
                _buildTeamSection(),

                SizedBox(height: 24.h),

                // Technology Stack
                _buildTechnologySection(),

                SizedBox(height: 24.h),

                // Statistics
                _buildStatisticsSection(),

                SizedBox(height: 24.h),

                // Legal & Credits
                _buildLegalSection(),

                SizedBox(height: 24.h),

                // Version Info
                _buildVersionSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return _buildSection(
      'LocateLost',
      Icons.my_location,
      AppColors.primary,
      Column(
        children: [
          // App Logo/Icon
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.my_location,
              color: Colors.white,
              size: 50.sp,
            ),
          ),
          
          SizedBox(height: 20.h),
          
          Text(
            'LocateLost',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            'Helping Families Reunite',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(
              'Version 1.2.3',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    return _buildSection(
      'Our Mission',
      Icons.favorite,
      AppColors.error,
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.error.withOpacity(0.1),
              AppColors.warning.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.error.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              Icons.family_restroom,
              size: 48.sp,
              color: AppColors.error,
            ),
            SizedBox(height: 16.h),
            Text(
              'To leverage technology in reuniting families and bringing missing persons home safely.',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textPrimary,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMissionValue('Hope', Icons.light_mode),
                _buildMissionValue('Technology', Icons.psychology),
                _buildMissionValue('Community', Icons.people_alt),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return _buildSection(
      'Key Features',
      Icons.star,
      AppColors.warning,
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.1,
        ),
        itemCount: _features.length,
        itemBuilder: (context, index) {
          final feature = _features[index];
          return _buildFeatureCard(feature);
        },
      ),
    );
  }

  Widget _buildTeamSection() {
    return _buildSection(
      'Meet the Team',
      Icons.group,
      AppColors.info,
      Column(
        children: [
          Text(
            'Passionate developers working to make a difference',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          ...(_teamMembers.map((member) => _buildTeamMember(member))),
          
          SizedBox(height: 20.h),
          
          // Contact Team Button
          OutlinedButton(
            onPressed: _contactTeam,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.email,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Contact Team',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologySection() {
    return _buildSection(
      'Technology Stack',
      Icons.settings,
      AppColors.success,
      Column(
        children: [
          Text(
            'Built with modern technologies for reliability and performance',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 2.5,
            ),
            itemCount: _technologies.length,
            itemBuilder: (context, index) {
              final tech = _technologies[index];
              return _buildTechnologyCard(tech);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return _buildSection(
      'Impact Statistics',
      Icons.analytics,
      AppColors.secondary,
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildStatCard('1,247', 'Cases Reported', AppColors.primary)),
                SizedBox(width: 16.w),
                Expanded(child: _buildStatCard('892', 'Successfully Resolved', AppColors.success)),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(child: _buildStatCard('15,000+', 'Active Users', AppColors.info)),
                SizedBox(width: 16.w),
                Expanded(child: _buildStatCard('98%', 'Success Rate', AppColors.warning)),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.volunteer_activism,
                    color: AppColors.success,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Community Impact',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '5,000+ volunteers actively helping in search operations',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalSection() {
    return _buildSection(
      'Legal & Credits',
      Icons.gavel,
      AppColors.textSecondary,
      Column(
        children: [
          _buildLegalItem('Privacy Policy', Icons.privacy_tip, () => _openPrivacyPolicy()),
          _buildLegalItem('Terms of Service', Icons.description, () => _openTermsOfService()),
          _buildLegalItem('Open Source Licenses', Icons.code, () => _openLicenses()),
          _buildLegalItem('Acknowledgments', Icons.favorite, () => _openAcknowledgments()),
          
          SizedBox(height: 16.h),
          
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Text(
                  '© 2023 LocateLost Team',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'All rights reserved. Made with ❤️ for families everywhere.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionSection() {
    return _buildSection(
      'Version Information',
      Icons.info_outline,
      AppColors.primary,
      Column(
        children: [
          _buildVersionItem('App Version', '1.2.3'),
          _buildVersionItem('Build Number', '123'),
          _buildVersionItem('Release Date', 'December 24, 2023'),
          _buildVersionItem('Platform', 'Flutter 3.16.0'),
          _buildVersionItem('Minimum OS', 'Android 6.0 / iOS 12.0'),
          
          SizedBox(height: 16.h),
          
          // Update Check
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _checkForUpdates,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.system_update,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Check for Updates',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, Color color, Widget child) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, _) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Container(
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
                // Section Header
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.h),
                
                child,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMissionValue(String title, IconData icon) {
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            color: AppColors.error,
            size: 24.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            feature['icon'],
            color: AppColors.warning,
            size: 32.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            feature['title'],
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            feature['description'],
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.info.withOpacity(0.1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                member['image'],
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    color: AppColors.info,
                    size: 32.sp,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member['name'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  member['role'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  member['bio'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologyCard(Map<String, dynamic> tech) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(
            tech['logo'],
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tech['name'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  tech['description'],
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLegalItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                ),
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
    );
  }

  Widget _buildVersionItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // Action methods
  void _contactTeam() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening email to contact team...')),
    );
  }

  void _openPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening Privacy Policy...')),
    );
  }

  void _openTermsOfService() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening Terms of Service...')),
    );
  }

  void _openLicenses() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening Open Source Licenses...')),
    );
  }

  void _openAcknowledgments() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening Acknowledgments...')),
    );
  }

  void _checkForUpdates() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Checking for updates...'),
        backgroundColor: AppColors.info,
      ),
    );
    
    // Simulate update check
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have the latest version!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    });
  }
}
