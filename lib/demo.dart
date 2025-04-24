import 'package:flutter/material.dart';
import 'package:locat_lost/colors.dart';

class CustomAppBarr extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool showBackButton;

  const CustomAppBarr({
    super.key,
    required this.text,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Ensures no overlap with status bar
      child: Builder(
        builder: (context) => Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Title
              Text(
                text,
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Icon (either back or menu)
              Positioned(
                left: 10,
                child: IconButton(
                  onPressed: () {
                    if (showBackButton) {
                      Navigator.of(context).pop();
                    } else {
                      Scaffold.of(context).openDrawer();
                    }
                  },
                  icon: Icon(
                    showBackButton
                        ? Icons.arrow_circle_left_outlined
                        : Icons.menu,
                    color: AppColors.secondary,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
