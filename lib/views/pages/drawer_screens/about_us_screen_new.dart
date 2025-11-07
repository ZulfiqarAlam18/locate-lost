import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';

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
        'name': 'Ali Raza',
        'role': 'Full Stack Developer',
        'image': 'assets/images/ali.png',
        'color': Color(0xFF8B5CF6),
        'skills': ['Web Dev', 'Backend', 'UI/UX'],
      },
      {
        'name': 'Zulfiqar Alam',
        'role': 'Flutter Developer',
        'image': 'assets/images/zulfiqar.png',
        'color': Color(0xFF06B6D4),
        'skills': ['Mobile', 'Flutter', 'Design'],
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

    return Container(
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
}
