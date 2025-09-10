import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/core/constants/app_colors.dart';

class MultiStepProgressDialog extends StatefulWidget {
  final List<ProgressStep> steps;
  final int currentStep;
  final String? subtitle;
  final VoidCallback? onCancel;
  final Duration stepTransitionDuration;

  const MultiStepProgressDialog({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.subtitle,
    this.onCancel,
    this.stepTransitionDuration = const Duration(milliseconds: 800),
  });

  @override
  State<MultiStepProgressDialog> createState() => _MultiStepProgressDialogState();
}

class _MultiStepProgressDialogState extends State<MultiStepProgressDialog>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _stepController;
  late AnimationController _scaleController;

  late Animation<double> _progressAnimation;
  late Animation<double> _stepAnimation;
  late Animation<double> _scaleAnimation;

  int _animatedCurrentStep = 0;

  @override
  void initState() {
    super.initState();
    
    _progressController = AnimationController(
      duration: widget.stepTransitionDuration,
      vsync: this,
    );
    
    _stepController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _stepAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _stepController,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _scaleController.forward();
    _updateProgress();
  }

  void _updateProgress() {
    final targetProgress = widget.currentStep / (widget.steps.length - 1);
    _progressController.animateTo(targetProgress);
    
    if (widget.currentStep != _animatedCurrentStep) {
      _stepController.forward().then((_) {
        setState(() {
          _animatedCurrentStep = widget.currentStep;
        });
        _stepController.reset();
        _stepController.forward();
      });
    }
  }

  @override
  void didUpdateWidget(MultiStepProgressDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _updateProgress();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _stepController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20.r,
                    offset: Offset(0, 8.h),
                  ),
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 40.r,
                    spreadRadius: 2.r,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Progress indicator
                  _buildProgressIndicator(),
                  
                  SizedBox(height: 32.h),
                  
                  // Current step animation
                  _buildCurrentStepDisplay(),
                  
                  if (widget.subtitle != null) ...[
                    SizedBox(height: 16.h),
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
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        // Step indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.steps.length, (index) {
            final isCompleted = index < widget.currentStep;
            final isCurrent = index == widget.currentStep;
            
            return AnimatedBuilder(
              animation: _stepAnimation,
              builder: (context, child) {
                return Column(
                  children: [
                    // Step circle
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted 
                          ? AppColors.primary
                          : isCurrent 
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : Colors.grey[300],
                        border: isCurrent
                          ? Border.all(
                              color: AppColors.primary,
                              width: 2.w,
                            )
                          : null,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isCompleted
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20.sp,
                              key: ValueKey('check_$index'),
                            )
                          : isCurrent
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                key: ValueKey('progress_$index'),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.w,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              )
                            : Icon(
                                widget.steps[index].icon,
                                color: Colors.grey[500],
                                size: 20.sp,
                                key: ValueKey('icon_$index'),
                              ),
                      ),
                    ),
                    
                    SizedBox(height: 8.h),
                    
                    // Step label
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        widget.steps[index].label,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isCurrent || isCompleted
                            ? AppColors.primary
                            : Colors.grey[500],
                          fontWeight: isCurrent || isCompleted
                            ? FontWeight.w600
                            : FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ),
        
        SizedBox(height: 24.h),
        
        // Progress bar
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progressAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCurrentStepDisplay() {
    if (widget.currentStep >= widget.steps.length) return const SizedBox();
    
    final currentStepData = widget.steps[widget.currentStep];
    
    return AnimatedBuilder(
      animation: _stepAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (_stepAnimation.value * 0.2),
          child: Opacity(
            opacity: _stepAnimation.value,
            child: Column(
              children: [
                // Current step icon
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    currentStepData.icon,
                    size: 30.sp,
                    color: AppColors.primary,
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Current step title
                Text(
                  currentStepData.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                if (currentStepData.description != null) ...[
                  SizedBox(height: 8.h),
                  Text(
                    currentStepData.description!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProgressStep {
  final String label;
  final String title;
  final String? description;
  final IconData icon;

  const ProgressStep({
    required this.label,
    required this.title,
    this.description,
    required this.icon,
  });
}

// Helper class for multi-step progress
class MultiStepProgressHelper {
  static void show({
    required BuildContext context,
    required List<ProgressStep> steps,
    int currentStep = 0,
    String? subtitle,
    VoidCallback? onCancel,
    Duration stepTransitionDuration = const Duration(milliseconds: 800),
  }) {
    showDialog(
      context: context,
      barrierDismissible: onCancel != null,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => MultiStepProgressDialog(
        steps: steps,
        currentStep: currentStep,
        subtitle: subtitle,
        onCancel: onCancel,
        stepTransitionDuration: stepTransitionDuration,
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
