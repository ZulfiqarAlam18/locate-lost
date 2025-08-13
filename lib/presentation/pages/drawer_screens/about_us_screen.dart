import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/core/constants/app_colors.dart';
import 'package:locat_lost/presentation/widgets/custom_app_bar.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
      backgroundColor: Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        text: 'About Us',
        onPressed: () => Navigator.pop(context),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroSection(),
              _buildTeamSection(),
              _buildMissionSection(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.favorite_rounded, size: 48.w, color: Colors.white),
          SizedBox(height: 16.h),
          Text(
            'LocateLost',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Reuniting families through technology',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Team',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Meet the passionate developers behind LocateLost',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),
          _buildTeamCards(),
        ],
      ),
    );
  }

  Widget _buildTeamCards() {
    final teamMembers = [
      {
        'name': 'Zulfiqar Alam',
        'role': 'Flutter Developer',
        'image': 'assets/images/zulfiqar.png',
        'color': Color(0xFF06B6D4),
        'skills': ['Mobile', 'Flutter', 'Design'],
        'detailedSkills': [
          'Flutter Development',
          'Dart Programming',
          'UI/UX Design',
          'Mobile App Architecture',
          'State Management (Provider, Riverpod)',
          'Firebase Integration',
          'REST API Integration',
          'Git Version Control',
        ],
        'portfolio': 'https://zulfiqaralam.dev',
        'bio':
            'Passionate Flutter developer with expertise in creating beautiful, responsive mobile applications. Specialized in modern UI design and smooth user experiences.',
      },
      {
        'name': 'Ali Raza',
        'role': 'Full Stack Developer',
        'image': 'assets/images/ali.png',
        'color': Color(0xFF8B5CF6),
        'skills': ['Web Dev', 'Backend', 'UI/UX'],
        'detailedSkills': [
          'React.js & Next.js',
          'Node.js & Express',
          'MongoDB & PostgreSQL',
          'RESTful APIs',
          'GraphQL',
          'AWS & Docker',
          'TypeScript',
          'Web Security',
        ],
        'portfolio': 'https://aliraza.dev',
        'bio':
            'Full-stack developer with strong expertise in modern web technologies. Focused on building scalable applications and robust backend systems.',
      },
    ];

    return Column(
      children:
          teamMembers.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> member = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _buildModernTeamCard(member, index),
            );
          }).toList(),
    );
  }

  Widget _buildModernTeamCard(Map<String, dynamic> member, int index) {
    bool isEven = index % 2 == 0;

    return GestureDetector(
      onTap: () => _showMemberDetails(member),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            if (!isEven) ...[
              Expanded(child: _buildTeamInfo(member)),
              SizedBox(width: 16.w),
            ],
            _buildTeamAvatar(member),
            if (isEven) ...[
              SizedBox(width: 16.w),
              Expanded(child: _buildTeamInfo(member)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTeamAvatar(Map<String, dynamic> member) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            (member['color'] as Color).withOpacity(0.8),
            member['color'] as Color,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: (member['color'] as Color).withOpacity(0.3),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: ClipOval(
              child: Image.asset(
                member['image'] as String,
                width: 70.w,
                height: 70.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamInfo(Map<String, dynamic> member) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member['name'] as String,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          member['role'] as String,
          style: TextStyle(
            fontSize: 14.sp,
            color: member['color'] as Color,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children:
              (member['skills'] as List<String>).map((skill) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: (member['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: member['color'] as Color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () => _showMemberDetails(member),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: (member['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: member['color'] as Color, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14.w,
                  color: member['color'] as Color,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Know More',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: member['color'] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMissionSection() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.primary,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'We leverage cutting-edge technology to reunite missing children with their families. Our app combines AI-powered facial recognition with community support to create a powerful platform for hope and connection.',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              _buildStatChip(Icons.security, 'Secure'),
              SizedBox(width: 12.w),
              _buildStatChip(Icons.speed, 'Fast'),
              SizedBox(width: 12.w),
              _buildStatChip(Icons.favorite, 'Caring'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.w, color: Colors.grey[600]),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showMemberDetails(Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(20.w),
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Section
                Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            (member['color'] as Color).withOpacity(0.8),
                            member['color'] as Color,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (member['color'] as Color).withOpacity(0.3),
                            blurRadius: 12.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.w),
                            child: ClipOval(
                              child: Image.asset(
                                member['image'] as String,
                                width: 54.w,
                                height: 54.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member['name'] as String,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            member['role'] as String,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: member['color'] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 20.w,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Bio Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: (member['color'] as Color).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    member['bio'] as String,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Skills Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Technical Skills',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children:
                      (member['detailedSkills'] as List<String>).map((skill) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: (member['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: (member['color'] as Color).withOpacity(
                                0.3,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: member['color'] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(height: 24.h),

                // Portfolio Button
                GestureDetector(
                  onTap: () {
                    // You can add URL launcher here to open portfolio
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Portfolio: ${member['portfolio']}'),
                        backgroundColor: member['color'] as Color,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (member['color'] as Color).withOpacity(0.8),
                          member['color'] as Color,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: (member['color'] as Color).withOpacity(0.3),
                          blurRadius: 8.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.launch, size: 18.w, color: Colors.white),
                        SizedBox(width: 8.w),
                        Text(
                          'View Portfolio',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
