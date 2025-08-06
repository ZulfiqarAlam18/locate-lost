import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class SupportSettingsScreen extends StatefulWidget {
  const SupportSettingsScreen({super.key});

  @override
  State<SupportSettingsScreen> createState() => _SupportSettingsScreenState();
}

class _SupportSettingsScreenState extends State<SupportSettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _feedbackController = TextEditingController();
  String _selectedCategory = 'General';
  int _selectedRating = 0;

  final List<Map<String, dynamic>> _supportOptions = [
    {
      'title': 'Help Center',
      'subtitle': 'Browse articles and guides',
      'icon': Icons.help_center,
      'color': AppColors.primary,
      'action': 'help_center',
    },
    {
      'title': 'Contact Support',
      'subtitle': 'Get help from our team',
      'icon': Icons.support_agent,
      'color': AppColors.info,
      'action': 'contact_support',
    },
    {
      'title': 'Live Chat',
      'subtitle': 'Chat with support (9 AM - 6 PM)',
      'icon': Icons.chat,
      'color': AppColors.success,
      'action': 'live_chat',
      'badge': 'Online',
    },
    {
      'title': 'Report Bug',
      'subtitle': 'Report technical issues',
      'icon': Icons.bug_report,
      'color': AppColors.error,
      'action': 'report_bug',
    },
    {
      'title': 'Feature Request',
      'subtitle': 'Suggest new features',
      'icon': Icons.lightbulb,
      'color': AppColors.warning,
      'action': 'feature_request',
    },
    {
      'title': 'Community Forum',
      'subtitle': 'Connect with other users',
      'icon': Icons.forum,
      'color': AppColors.secondary,
      'action': 'community',
    },
  ];

  final List<Map<String, dynamic>> _faqCategories = [
    {
      'title': 'Getting Started',
      'icon': Icons.play_arrow,
      'count': 12,
      'items': [
        'How to create an account?',
        'Setting up your profile',
        'Understanding the interface',
        'Privacy and safety basics',
      ],
    },
    {
      'title': 'Case Management',
      'icon': Icons.folder,
      'count': 18,
      'items': [
        'How to report a missing person?',
        'Updating case information',
        'Case status meanings',
        'Closing a resolved case',
      ],
    },
    {
      'title': 'Communication',
      'icon': Icons.message,
      'count': 8,
      'items': [
        'Contacting case participants',
        'Managing notifications',
        'Using the chat feature',
        'Emergency contacts',
      ],
    },
    {
      'title': 'Account & Privacy',
      'icon': Icons.security,
      'count': 15,
      'items': [
        'Managing your privacy settings',
        'Two-factor authentication',
        'Data security measures',
        'Account recovery',
      ],
    },
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
    _feedbackController.dispose();
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
          'Support & Help',
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
                // Quick Support Actions
                _buildQuickSupportSection(),

                SizedBox(height: 24.h),

                // FAQ Section
                _buildFAQSection(),

                SizedBox(height: 24.h),

                // Feedback Section
                _buildFeedbackSection(),

                SizedBox(height: 24.h),

                // Contact Information
                _buildContactInfoSection(),

                SizedBox(height: 24.h),

                // System Information
                _buildSystemInfoSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickSupportSection() {
    return _buildSection(
      'Quick Support',
      Icons.flash_on,
      AppColors.primary,
      Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 1.2,
            ),
            itemCount: _supportOptions.length,
            itemBuilder: (context, index) {
              final option = _supportOptions[index];
              return _buildSupportCard(option);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return _buildSection(
      'Frequently Asked Questions',
      Icons.quiz,
      AppColors.info,
      Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search help articles...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.sp,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // FAQ Categories
          ...(_faqCategories.map((category) => _buildFAQCategory(category))),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return _buildSection(
      'Send Feedback',
      Icons.feedback,
      AppColors.warning,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Section
          Text(
            'Rate your experience',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => setState(() => _selectedRating = index + 1),
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    Icons.star,
                    size: 32.sp,
                    color: index < _selectedRating
                        ? AppColors.warning
                        : Colors.grey[300],
                  ),
                ),
              );
            }),
          ),
          
          SizedBox(height: 20.h),
          
          // Category Selection
          Text(
            'Category',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            items: ['General', 'Bug Report', 'Feature Request', 'UI/UX', 'Performance']
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _selectedCategory = value!),
          ),
          
          SizedBox(height: 16.h),
          
          // Feedback Text
          Text(
            'Your feedback',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _feedbackController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Tell us about your experience or suggest improvements...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              contentPadding: EdgeInsets.all(16.w),
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Send Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _sendFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Send Feedback',
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

  Widget _buildContactInfoSection() {
    return _buildSection(
      'Contact Information',
      Icons.contact_support,
      AppColors.success,
      Column(
        children: [
          _buildContactItem(
            'Email Support',
            'support@locatelost.com',
            Icons.email,
            AppColors.primary,
            () => _launchEmail('support@locatelost.com'),
          ),
          _buildContactItem(
            'Emergency Hotline',
            '+1 (800) 123-4567',
            Icons.phone,
            AppColors.error,
            () => _launchPhone('+18001234567'),
            isEmergency: true,
          ),
          _buildContactItem(
            'Business Hours',
            'Mon-Fri: 9 AM - 6 PM EST',
            Icons.schedule,
            AppColors.info,
            null,
          ),
          _buildContactItem(
            'Response Time',
            'Within 24 hours',
            Icons.timer,
            AppColors.success,
            null,
          ),
          
          SizedBox(height: 16.h),
          
          // Social Media Links
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
                  'Follow us for updates',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialButton('Twitter', Icons.alternate_email, AppColors.info),
                    _buildSocialButton('Facebook', Icons.facebook, AppColors.primary),
                    _buildSocialButton('Instagram', Icons.camera_alt, AppColors.secondary),
                    _buildSocialButton('LinkedIn', Icons.business, AppColors.textPrimary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemInfoSection() {
    return _buildSection(
      'System Information',
      Icons.info,
      AppColors.textSecondary,
      Column(
        children: [
          _buildInfoRow('App Version', '1.2.3'),
          _buildInfoRow('Platform', 'Android 13'),
          _buildInfoRow('Device Model', 'Google Pixel 7'),
          _buildInfoRow('Last Updated', 'December 24, 2023'),
          
          SizedBox(height: 16.h),
          
          // Export System Info Button
          OutlinedButton(
            onPressed: _exportSystemInfo,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.download,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Export System Info',
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

  Widget _buildSupportCard(Map<String, dynamic> option) {
    return GestureDetector(
      onTap: () => _handleSupportAction(option['action']),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: option['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: option['color'].withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Icon(
                  option['icon'],
                  color: option['color'],
                  size: 32.sp,
                ),
                if (option['badge'] != null)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        option['badge'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              option['title'],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              option['subtitle'],
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
      ),
    );
  }

  Widget _buildFAQCategory(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            category['icon'],
            color: AppColors.info,
            size: 20.sp,
          ),
        ),
        title: Text(
          category['title'],
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          '${category['count']} articles',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        children: category['items'].map<Widget>((item) {
          return ListTile(
            dense: true,
            title: Text(
              item,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 12.sp,
              color: AppColors.textSecondary,
            ),
            onTap: () => _openFAQItem(item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContactItem(
    String title,
    String value,
    IconData icon,
    Color color,
    VoidCallback? onTap, {
    bool isEmergency = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: isEmergency
                  ? AppColors.error.withOpacity(0.3)
                  : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(12.r),
            color: isEmergency ? AppColors.error.withOpacity(0.05) : null,
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
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
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
  }

  Widget _buildSocialButton(String name, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _openSocialMedia(name),
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Icon(
          icon,
          color: color,
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
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

  // Action Methods
  void _handleSupportAction(String action) {
    switch (action) {
      case 'help_center':
        _openHelpCenter();
        break;
      case 'contact_support':
        _contactSupport();
        break;
      case 'live_chat':
        _startLiveChat();
        break;
      case 'report_bug':
        _reportBug();
        break;
      case 'feature_request':
        _requestFeature();
        break;
      case 'community':
        _openCommunity();
        break;
    }
  }

  void _openHelpCenter() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening Help Center...')),
    );
  }

  void _contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening support contact form...')),
    );
  }

  void _startLiveChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connecting to live chat...'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _reportBug() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening bug report form...')),
    );
  }

  void _requestFeature() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening feature request form...')),
    );
  }

  void _openCommunity() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening community forum...')),
    );
  }

  void _openFAQItem(String item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening FAQ: $item')),
    );
  }

  void _launchEmail(String email) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening email client for $email')),
    );
  }

  void _launchPhone(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $phone')),
    );
  }

  void _openSocialMedia(String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening $platform')),
    );
  }

  void _exportSystemInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('System information exported successfully'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _sendFeedback() {
    if (_feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your feedback'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thank you for your feedback!'),
        backgroundColor: AppColors.success,
      ),
    );

    // Clear form
    _feedbackController.clear();
    setState(() {
      _selectedRating = 0;
      _selectedCategory = 'General';
    });
  }
}
