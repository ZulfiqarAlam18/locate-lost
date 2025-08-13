import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonShimmer extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final Duration period;
  final Color baseColor;
  final Color highlightColor;

  const SkeletonShimmer({
    super.key,
    required this.child,
    this.enabled = true,
    this.period = const Duration(milliseconds: 1500),
    Color? baseColor,
    Color? highlightColor,
  }) : baseColor = baseColor ?? const Color(0xFFE0E0E0),
       highlightColor = highlightColor ?? const Color(0xFFF5F5F5);

  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.period,
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(SkeletonShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                0.0,
                0.5,
                1.0,
              ],
              transform: GradientRotation(_animation.value),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

// Predefined skeleton components
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;

  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(4.r),
      ),
    );
  }
}

class SkeletonLine extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLine({
    super.key,
    this.width,
    this.height = 16.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
    );
  }
}

class SkeletonAvatar extends StatelessWidget {
  final double size;
  final bool isCircular;

  const SkeletonAvatar({
    super.key,
    this.size = 50.0,
    this.isCircular = true,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: size,
      height: size,
      borderRadius: isCircular 
        ? BorderRadius.circular(size / 2) 
        : BorderRadius.circular(8.r),
    );
  }
}

// Predefined skeleton layouts
class SkeletonCardLoader extends StatelessWidget {
  final bool showAvatar;
  final int lineCount;
  final bool showButton;

  const SkeletonCardLoader({
    super.key,
    this.showAvatar = true,
    this.lineCount = 3,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and title
            if (showAvatar) ...[
              Row(
                children: [
                  SkeletonAvatar(size: 40.w),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(width: 120.w, height: 16.h),
                        SizedBox(height: 8.h),
                        SkeletonLine(width: 80.w, height: 12.h),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
            
            // Content lines
            ...List.generate(lineCount, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: SkeletonLine(
                  width: index == lineCount - 1 
                    ? 150.w + (index * 30.w) 
                    : double.infinity,
                  height: 14.h,
                ),
              );
            }),
            
            if (showButton) ...[
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SkeletonBox(
                    width: 80.w,
                    height: 32.h,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  SizedBox(width: 12.w),
                  SkeletonBox(
                    width: 100.w,
                    height: 32.h,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SkeletonListLoader extends StatelessWidget {
  final int itemCount;
  final bool showAvatar;
  final int lineCount;

  const SkeletonListLoader({
    super.key,
    this.itemCount = 5,
    this.showAvatar = true,
    this.lineCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return SkeletonShimmer(
          child: Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: Row(
              children: [
                if (showAvatar) ...[
                  SkeletonAvatar(size: 50.w),
                  SizedBox(width: 16.w),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(lineCount, (lineIndex) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: SkeletonLine(
                          width: lineIndex == lineCount - 1 
                            ? 120.w + (lineIndex * 40.w)
                            : double.infinity,
                          height: 14.h,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// Fade transition helper for smooth content loading
class FadeInContent extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool show;

  const FadeInContent({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.show = true,
  });

  @override
  State<FadeInContent> createState() => _FadeInContentState();
}

class _FadeInContentState extends State<FadeInContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    if (widget.show) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(FadeInContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show != oldWidget.show) {
      if (widget.show) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      },
    );
  }
}
