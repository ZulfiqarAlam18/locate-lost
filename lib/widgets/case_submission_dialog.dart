import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../routes/app_routes.dart';
import 'dart:math' as math;

enum SubmissionStatus { success, error }

class CaseSubmissionDialog extends StatefulWidget {
  final SubmissionStatus status;
  final String? customTitle;
  final String? customMessage;
  final VoidCallback? onRetry;
  final VoidCallback? onViewCases;

  const CaseSubmissionDialog({
    super.key,
    required this.status,
    this.customTitle,
    this.customMessage,
    this.onRetry,
    this.onViewCases,
  });

  @override
  State<CaseSubmissionDialog> createState() => _CaseSubmissionDialogState();
  
  // Static method to show success dialog
  static void showSuccess({
    String? title,
    String? message,
    VoidCallback? onViewCases,
  }) {
    Get.dialog(
      CaseSubmissionDialog(
        status: SubmissionStatus.success,
        customTitle: title,
        customMessage: message,
        onViewCases: onViewCases,
      ),
      barrierDismissible: false,
    );
  }
  
  // Static method to show error dialog
  static void showError({
    String? title,
    String? message,
    VoidCallback? onRetry,
  }) {
    Get.dialog(
      CaseSubmissionDialog(
        status: SubmissionStatus.error,
        customTitle: title,
        customMessage: message,
        onRetry: onRetry,
      ),
      barrierDismissible: false,
    );
  }
}

class _CaseSubmissionDialogState extends State<CaseSubmissionDialog>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _confettiController;
  late AnimationController _iconController;
  
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconRotationAnimation;
  
  final List<ConfettiParticle> _confettiParticles = [];
  
  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
    if (widget.status == SubmissionStatus.success) {
      _generateConfetti();
    }
  }
  
  void _setupAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.elasticOut,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeInOut,
    ));
    
    _iconScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.elasticOut,
    ));
    
    _iconRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _iconController,
      curve: Curves.easeInOut,
    ));
  }
  
  void _startAnimations() async {
    await _mainController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _iconController.forward();
    if (widget.status == SubmissionStatus.success) {
      _confettiController.forward();
    }
  }
  
  void _generateConfetti() {
    final random = math.Random();
    for (int i = 0; i < 20; i++) {
      _confettiParticles.add(ConfettiParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        color: _getRandomConfettiColor(),
        size: random.nextDouble() * 8 + 4,
        velocity: random.nextDouble() * 2 + 1,
        rotation: random.nextDouble() * 2 * math.pi,
      ));
    }
  }
  
  Color _getRandomConfettiColor() {
    final colors = [
      AppColors.primary,
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ];
    return colors[math.Random().nextInt(colors.length)];
  }
  
  @override
  void dispose() {
    _mainController.dispose();
    _confettiController.dispose();
    _iconController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            children: [
              // Confetti layer
              if (widget.status == SubmissionStatus.success)
                AnimatedBuilder(
                  animation: _confettiController,
                  builder: (context, child) => _buildConfetti(),
                ),
              
              // Main dialog content
              _buildDialogContent(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildConfetti() {
    return Container(
      width: 300.w,
      height: 400.h,
      child: CustomPaint(
        painter: ConfettiPainter(
          particles: _confettiParticles,
          animation: _confettiController,
        ),
      ),
    );
  }
  
  Widget _buildDialogContent() {
    final isSuccess = widget.status == SubmissionStatus.success;
    
    return Container(
      width: 320.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 40,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          _buildIcon(isSuccess),
          
          SizedBox(height: 24.h),
          
          // Title
          Text(
            _getTitle(isSuccess),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isSuccess ? AppColors.primary : Colors.red[700],
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 12.h),
          
          // Message
          Text(
            _getMessage(isSuccess),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 32.h),
          
          // Action buttons
          _buildActionButtons(isSuccess),
        ],
      ),
    );
  }
  
  Widget _buildIcon(bool isSuccess) {
    return AnimatedBuilder(
      animation: _iconController,
      builder: (context, child) {
        return Transform.scale(
          scale: _iconScaleAnimation.value,
          child: Transform.rotate(
            angle: _iconRotationAnimation.value * 0.2,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: (isSuccess ? AppColors.primary : Colors.red[500])!.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
                size: 48.sp,
                color: isSuccess ? AppColors.primary : Colors.red[500],
              ),
            ),
          ),
        );
      },
    );
  }
  
  String _getTitle(bool isSuccess) {
    if (widget.customTitle != null) return widget.customTitle!;
    return isSuccess ? 'Report Submitted!' : 'Submission Failed';
  }
  
  String _getMessage(bool isSuccess) {
    if (widget.customMessage != null) return widget.customMessage!;
    return isSuccess 
        ? 'Your case has been recorded. We\'ll notify you if a match is found.'
        : 'Something went wrong while submitting your case. Please try again.';
  }
  
  Widget _buildActionButtons(bool isSuccess) {
    if (isSuccess) {
      return Column(
        children: [
          // View My Cases button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                if (widget.onViewCases != null) {
                  widget.onViewCases!();
                } else {
                  Get.toNamed(AppRoutes.myCases);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'View My Cases',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 12.h),
          
          // Close button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          // Retry button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                if (widget.onRetry != null) {
                  widget.onRetry!();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 12.h),
          
          // Cancel button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

// Confetti particle model
class ConfettiParticle {
  double x;
  double y;
  final Color color;
  final double size;
  final double velocity;
  final double rotation;
  
  ConfettiParticle({
    required this.x,
    required this.y,
    required this.color,
    required this.size,
    required this.velocity,
    required this.rotation,
  });
}

// Custom painter for confetti animation
class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final Animation<double> animation;
  
  ConfettiPainter({
    required this.particles,
    required this.animation,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color.withOpacity(1.0 - animation.value)
        ..style = PaintingStyle.fill;
      
      canvas.save();
      
      // Calculate position with animation
      final animatedY = particle.y + (animation.value * particle.velocity * size.height);
      final animatedX = particle.x * size.width + 
          (math.sin(animation.value * 4 + particle.rotation) * 20);
      
      canvas.translate(animatedX, animatedY);
      canvas.rotate(particle.rotation + animation.value * 4);
      
      // Draw particle (rectangle or circle)
      if (particle.size > 6) {
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: particle.size, height: particle.size),
          paint,
        );
      } else {
        canvas.drawCircle(Offset.zero, particle.size / 2, paint);
      }
      
      canvas.restore();
    }
  }
  
  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}
