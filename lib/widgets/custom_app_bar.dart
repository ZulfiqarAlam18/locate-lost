import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

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
  Size get preferredSize => const Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
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
          Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: Builder(
              builder: (context) => IconButton(
                icon: Icon(icon, color: AppColors.secondary, size: 30),
                onPressed: () {
                  if (icon == Icons.menu) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    if (onPressed != null) {
                      onPressed!();
                    }
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









// import 'package:flutter/material.dart';
//
// import '../utils/app_colors.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final IconData icon;
//
//   const CustomAppBar({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.icon = Icons.arrow_circle_left_outlined,
//   });
//
//   @override
//   Size get preferredSize => const Size.fromHeight(110); // Match the height of your container
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 60),
//       width: double.infinity,
//       height: 110,
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: const BorderRadius.only(
//           bottomRight: Radius.circular(30),
//           bottomLeft: Radius.circular(30),
//         ),
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 22,
//               color: AppColors.secondary,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 0,
//             bottom: 0,
//             child: IconButton(
//               onPressed: onPressed,
//               icon: Icon(icon, color: AppColors.secondary, size: 30),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
