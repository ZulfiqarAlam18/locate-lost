import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/colors.dart';

import 'founder_screens/image.dart';
import 'parent_screens/p_child_info.dart';

class ReportCase extends StatelessWidget {
  const ReportCase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Report A Case',
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/report.png',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 2,
              color: AppColors.primary,
              indent: 80,
              endIndent: 80,
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '\" Let\'s ',
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poltawski Nowy',
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'reunite families ',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  const TextSpan(
                    text: 'with \ntheir ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'loved ones \"',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 2,
              color: AppColors.primary,
              indent: 80,
              endIndent: 80,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCaseCard(
                  context,
                  title1: 'Report a',
                  title2: 'Lost Person',
                  description:
                  'If you are looking for someone who is lost, tap here to report it.',
                  image: 'assets/images/unlink.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChildDetailsScreen()),
                  ),
                ),
                _buildCaseCard(
                  context,
                  title1: 'Report a',
                  title2: 'Found Person',
                  description:
                  'If you found someone who is lost, tap here to report it.',
                  image: 'assets/images/link-03.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FinderCameraScreen()),
                   //  builder: (context) => CapturePicturesScreen()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseCard(
      BuildContext context, {
        required String title1,
        required String title2,
        required String description,
        required String image,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 160,
          height: 205,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(image, width: 40, height: 40),
                const SizedBox(height: 10),
                Text(
                  title1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  title2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.arrow_circle_right_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





















