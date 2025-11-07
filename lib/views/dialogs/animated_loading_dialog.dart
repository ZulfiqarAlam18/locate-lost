import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';

class AnimatedLoadingDialog extends StatefulWidget {
  final String message;
  final String? subtitle;
  final bool showLogo;
  final VoidCallback? onCancel;
  final Duration animationDuration;

  const AnimatedLoadingDialog({
    super.key,
    this.message = 'Loading...',
    this.subtitle,
    this.showLogo = true,
    this.onCancel,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedLoadingDialog> createState() => _AnimatedLoadingDialogState();
}

class _AnimatedLoadingDialogState extends State<AnimatedLoadingDialog>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late AnimationController _typingController;
  late AnimationController _scaleController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _typingAnimation;
  late Animation<double> _scaleAnimation;

  int _currentTextLength = 0;
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _typingController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Setup animations
    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    _typingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _typingController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() {
    // Scale in animation
    _scaleController.forward();
    
    // Repeating pulse animation
    _pulseController.repeat(reverse: true);
    
    // Repeating glow animation
    _glowController.repeat(reverse: true);
    
    // Typing animation
    _typingController.addListener(_updateTypingText);
    _typingController.forward();
  }

  void _updateTypingText() {
    final progress = _typingAnimation.value;
    final targetLength = (widget.message.length * progress).round();
    
    if (targetLength != _currentTextLength) {
      setState(() {
        _currentTextLength = targetLength;
        _displayText = widget.message.substring(0, _currentTextLength);
        
        // Add typing cursor
        if (_currentTextLength < widget.message.length) {
          _displayText += '|';
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    _typingController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _scaleAnimation,
          _pulseAnimation,
          _glowAnimation,
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  // Soft shadow
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20.r,
                    offset: Offset(0, 8.h),
                  ),
                  // Animated glow effect
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: _glowAnimation.value * 0.3),
                    blurRadius: 40.r,
                    spreadRadius: 2.r,
                  ),
                ],
              ),
              child: Transform.scale(
                scale: _pulseAnimation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo/Icon section
                    if (widget.showLogo) ...[
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 2.w,
                          ),
                        ),
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 40.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Animated progress indicator
                    SizedBox(
                      width: 60.w,
                      height: 60.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background circle
                          Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withValues(alpha: 0.1),
                            ),
                          ),
                          // Animated circular progress
                          SizedBox(
                            width: 50.w,
                            height: 50.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.w,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                              backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                            ),
                          ),
                          // Inner pulsing dot
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Container(
                                width: 12.w * _pulseAnimation.value,
                                height: 12.w * _pulseAnimation.value,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Animated typing text
                    AnimatedBuilder(
                      animation: _typingAnimation,
                      builder: (context, child) {
                        return Column(
                          children: [
                            Text(
                              _displayText,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            if (widget.subtitle != null) ...[
                              SizedBox(height: 8.h),
                              Text(
                                widget.subtitle!,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        );
                      },
                    ),

                    // Cancel button (if provided)
                    if (widget.onCancel != null) ...[
                      SizedBox(height: 24.h),
                      TextButton(
                        onPressed: widget.onCancel,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Helper method to show the animated loading dialog
class LoadingDialogHelper {
  static void show({
    required BuildContext context,
    String message = 'Loading...',
    String? subtitle,
    bool showLogo = true,
    VoidCallback? onCancel,
    Duration animationDuration = const Duration(milliseconds: 1500),
  }) {
    showDialog(
      context: context,
      barrierDismissible: onCancel != null,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => AnimatedLoadingDialog(
        message: message,
        subtitle: subtitle,
        showLogo: showLogo,
        onCancel: onCancel,
        animationDuration: animationDuration,
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
