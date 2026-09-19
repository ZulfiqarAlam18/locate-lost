import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_lost/utils/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData icon;

  const CustomAppBar({
    super.key,
    required this.text,
    this.onPressed,
    this.icon = Icons.arrow_circle_left_outlined,
  });

  @override
  Size get preferredSize => Size.fromHeight(110.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60.h),
      width: double.infinity,
      height: 110.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30.r),
          bottomLeft: Radius.circular(30.r),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 22.sp,
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Positioned(
            left: 10.w,
            top: 0,
            bottom: 0,
            child: Builder(
              builder: (context) => IconButton(
                icon: Icon(icon, color: AppColors.secondary, size: 30.w),
                onPressed: () {
                  if (icon == Icons.menu) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    onPressed?.call();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
