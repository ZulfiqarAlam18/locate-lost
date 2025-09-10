import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String _selectedLanguage = 'English';
  String _selectedRegion = 'United States';
  bool _autoDetect = true;
  bool _translateContent = true;
  String _dateFormat = 'MM/DD/YYYY';
  String _timeFormat = '12-hour';
  String _numberFormat = 'US (1,234.56)';

  final List<Map<String, dynamic>> _languages = [
    {
      'name': 'English',
      'nativeName': 'English',
      'code': 'en',
      'flag': '🇺🇸',
      'isPopular': true,
    },
    {
      'name': 'Spanish',
      'nativeName': 'Español',
      'code': 'es',
      'flag': '🇪🇸',
      'isPopular': true,
    },
    {
      'name': 'French',
      'nativeName': 'Français',
      'code': 'fr',
      'flag': '🇫🇷',
      'isPopular': true,
    },
    {
      'name': 'German',
      'nativeName': 'Deutsch',
      'code': 'de',
      'flag': '🇩🇪',
      'isPopular': true,
    },
    {
      'name': 'Chinese (Simplified)',
      'nativeName': '简体中文',
      'code': 'zh',
      'flag': '🇨🇳',
      'isPopular': true,
    },
    {
      'name': 'Japanese',
      'nativeName': '日本語',
      'code': 'ja',
      'flag': '🇯🇵',
      'isPopular': true,
    },
    {
      'name': 'Arabic',
      'nativeName': 'العربية',
      'code': 'ar',
      'flag': '🇸🇦',
      'isPopular': false,
    },
    {
      'name': 'Portuguese',
      'nativeName': 'Português',
      'code': 'pt',
      'flag': '🇵🇹',
      'isPopular': false,
    },
    {
      'name': 'Russian',
      'nativeName': 'Русский',
      'code': 'ru',
      'flag': '🇷🇺',
      'isPopular': false,
    },
    {
      'name': 'Italian',
      'nativeName': 'Italiano',
      'code': 'it',
      'flag': '🇮🇹',
      'isPopular': false,
    },
    {
      'name': 'Dutch',
      'nativeName': 'Nederlands',
      'code': 'nl',
      'flag': '🇳🇱',
      'isPopular': false,
    },
    {
      'name': 'Korean',
      'nativeName': '한국어',
      'code': 'ko',
      'flag': '🇰🇷',
      'isPopular': false,
    },
  ];

  final List<String> _regions = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Spain',
    'Japan',
    'China',
    'India',
    'Brazil',
    'Mexico',
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
          'Language & Region',
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
                // Current Language Section
                _buildCurrentLanguageSection(),

                SizedBox(height: 24.h),

                // Language Selection
                _buildLanguageSelectionSection(),

                SizedBox(height: 24.h),

                // Regional Settings
                _buildRegionalSettingsSection(),

                SizedBox(height: 24.h),

                // Format Settings
                _buildFormatSettingsSection(),

                SizedBox(height: 24.h),

                // Translation Settings
                _buildTranslationSection(),

                SizedBox(height: 32.h),

                // Save Button
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentLanguageSection() {
    final currentLanguage = _languages.firstWhere(
      (lang) => lang['name'] == _selectedLanguage,
      orElse: () => _languages.first,
    );

    return _buildSection(
      'Current Language',
      Icons.language,
      AppColors.primary,
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Text(
              currentLanguage['flag'],
              style: TextStyle(fontSize: 32.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentLanguage['name'],
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    currentLanguage['nativeName'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      _selectedRegion,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: _showLanguagePicker,
              child: Text(
                'Change',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelectionSection() {
    final popularLanguages = _languages.where((lang) => lang['isPopular']).toList();

    return _buildSection(
      'Popular Languages',
      Icons.star,
      AppColors.warning,
      Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 3,
            ),
            itemCount: popularLanguages.length,
            itemBuilder: (context, index) {
              final language = popularLanguages[index];
              final isSelected = language['name'] == _selectedLanguage;

              return GestureDetector(
                onTap: () => setState(() => _selectedLanguage = language['name']),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        language['flag'],
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          language['name'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          SizedBox(height: 16.h),
          
          // More Languages Button
          InkWell(
            onTap: _showAllLanguages,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.more_horiz,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'View All Languages',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primary,
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

  Widget _buildRegionalSettingsSection() {
    return _buildSection(
      'Regional Settings',
      Icons.public,
      AppColors.info,
      Column(
        children: [
          _buildSwitchTile(
            'Auto-detect Region',
            'Automatically set region based on your location',
            _autoDetect,
            (value) => setState(() => _autoDetect = value),
          ),
          
          if (!_autoDetect) ...[
            SizedBox(height: 16.h),
            _buildSelectTile(
              'Region',
              _selectedRegion,
              Icons.location_on,
              () => _showRegionPicker(),
            ),
          ],
          
          SizedBox(height: 16.h),
          
          // Regional Info Card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.info,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Regional Impact',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your region affects date formats, number formats, currency display, and search suggestions.',
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
    );
  }

  Widget _buildFormatSettingsSection() {
    return _buildSection(
      'Format Settings',
      Icons.format_list_numbered,
      AppColors.success,
      Column(
        children: [
          _buildSelectTile(
            'Date Format',
            _dateFormat,
            Icons.calendar_today,
            () => _showDateFormatPicker(),
          ),
          _buildSelectTile(
            'Time Format',
            _timeFormat,
            Icons.access_time,
            () => _showTimeFormatPicker(),
          ),
          _buildSelectTile(
            'Number Format',
            _numberFormat,
            Icons.numbers,
            () => _showNumberFormatPicker(),
          ),
          
          SizedBox(height: 16.h),
          
          // Format Examples
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Format Examples',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildFormatExample('Date', _getDateExample()),
                _buildFormatExample('Time', _getTimeExample()),
                _buildFormatExample('Number', _getNumberExample()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationSection() {
    return _buildSection(
      'Translation Settings',
      Icons.translate,
      AppColors.secondary,
      Column(
        children: [
          _buildSwitchTile(
            'Auto-translate Content',
            'Automatically translate content to your preferred language',
            _translateContent,
            (value) => setState(() => _translateContent = value),
          ),
          
          SizedBox(height: 16.h),
          
          // Translation Services
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_sync,
                      color: AppColors.secondary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Translation Quality',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Powered by advanced AI translation services for accurate and contextual translations.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(
                      Icons.offline_bolt,
                      color: AppColors.success,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Works offline for popular languages',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
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
                SizedBox(height: 4.h),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withOpacity(0.3),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectTile(String title, String value, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
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

  Widget _buildFormatExample(String label, String example) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            example,
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

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveSettings,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 2,
        ),
        child: Text(
          'Apply Language Settings',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Helper methods for format examples
  String _getDateExample() {
    switch (_dateFormat) {
      case 'DD/MM/YYYY':
        return '24/12/2023';
      case 'YYYY-MM-DD':
        return '2023-12-24';
      case 'Month DD, YYYY':
        return 'December 24, 2023';
      default:
        return '12/24/2023';
    }
  }

  String _getTimeExample() {
    return _timeFormat == '24-hour' ? '14:30' : '2:30 PM';
  }

  String _getNumberExample() {
    switch (_numberFormat) {
      case 'EU (1.234,56)':
        return '1.234,56';
      case 'IN (1,23,456.78)':
        return '1,23,456.78';
      default:
        return '1,234.56';
    }
  }

  // Picker methods
  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    final isSelected = language['name'] == _selectedLanguage;

                    return ListTile(
                      leading: Text(
                        language['flag'],
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      title: Text(language['name']),
                      subtitle: Text(language['nativeName']),
                      trailing: isSelected
                          ? Icon(Icons.check, color: AppColors.primary)
                          : null,
                      onTap: () {
                        setState(() => _selectedLanguage = language['name']);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAllLanguages() {
    _showLanguagePicker();
  }

  void _showRegionPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Region',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: _regions.length,
                itemBuilder: (context, index) {
                  final region = _regions[index];
                  final isSelected = region == _selectedRegion;

                  return ListTile(
                    title: Text(region),
                    trailing: isSelected
                        ? Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () {
                      setState(() => _selectedRegion = region);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDateFormatPicker() {
    final formats = ['MM/DD/YYYY', 'DD/MM/YYYY', 'YYYY-MM-DD', 'Month DD, YYYY'];
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date Format',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            ...formats.map(
              (format) => ListTile(
                title: Text(format),
                trailing: format == _dateFormat
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _dateFormat = format);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimeFormatPicker() {
    final formats = ['12-hour', '24-hour'];
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Format',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            ...formats.map(
              (format) => ListTile(
                title: Text(format),
                trailing: format == _timeFormat
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _timeFormat = format);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNumberFormatPicker() {
    final formats = ['US (1,234.56)', 'EU (1.234,56)', 'IN (1,23,456.78)'];
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Number Format',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            ...formats.map(
              (format) => ListTile(
                title: Text(format),
                trailing: format == _numberFormat
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _numberFormat = format);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language settings applied successfully'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
