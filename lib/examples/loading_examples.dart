// Example usage of animated loading components

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locat_lost/presentation/dialogs/animated_loading_dialog.dart';
import 'package:locat_lost/presentation/dialogs/multi_step_progress_dialog.dart';
import '../presentation/widgets/skeleton_shimmer.dart';

class LoadingExampleScreen extends StatefulWidget {
  const LoadingExampleScreen({super.key});

  @override
  State<LoadingExampleScreen> createState() => _LoadingExampleScreenState();
}

class _LoadingExampleScreenState extends State<LoadingExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Examples')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Example 1: Animated Loading Dialog
            ElevatedButton(
              onPressed: () {
                LoadingDialogHelper.show(
                  context: context,
                  message: 'Processing your request...',
                  subtitle: 'This may take a few seconds',
                  showLogo: true,
                );

                // Auto close after 3 seconds
                Future.delayed(const Duration(seconds: 3), () {
                  LoadingDialogHelper.hide(context);
                });
              },
              child: const Text('Show Animated Loading Dialog'),
            ),

            SizedBox(height: 16.h),

            // Example 2: Multi-Step Progress
            ElevatedButton(
              onPressed: () {
                _showMultiStepProgress();
              },
              child: const Text('Show Multi-Step Progress'),
            ),

            SizedBox(height: 16.h),

            // Example 3: Skeleton Loaders
            Text('Skeleton Loaders:', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            
            SizedBox(height: 16.h),
            
            // Skeleton Card Example
            const SkeletonCardLoader(
              showAvatar: true,
              lineCount: 3,
              showButton: true,
            ),
            
            SizedBox(height: 16.h),
            
            // Skeleton List Example
            const Expanded(
              child: SkeletonListLoader(
                itemCount: 4,
                showAvatar: true,
                lineCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMultiStepProgress() {
    final steps = [
      const ProgressStep(
        label: 'Upload',
        title: 'Uploading Data',
        description: 'Uploading case information and images...',
        icon: Icons.cloud_upload_rounded,
      ),
      const ProgressStep(
        label: 'Match',
        title: 'Matching Records',
        description: 'Searching for similar cases in the database...',
        icon: Icons.search_rounded,
      ),
      const ProgressStep(
        label: 'Notify',
        title: 'Sending Notifications',
        description: 'Alerting nearby authorities and volunteers...',
        icon: Icons.notifications_active_rounded,
      ),
      const ProgressStep(
        label: 'Complete',
        title: 'Case Submitted',
        description: 'Your case has been successfully submitted!',
        icon: Icons.check_circle_rounded,
      ),
    ];

    MultiStepProgressHelper.show(
      context: context,
      steps: steps,
      currentStep: 0,
      subtitle: 'Processing your case submission...',
    );

    // Simulate progress through steps
    _simulateProgress(steps.length);
  }

  void _simulateProgress(int totalSteps) {
    int currentStep = 0;
    
    void nextStep() {
      if (currentStep < totalSteps - 1) {
        currentStep++;
        
        // Update the dialog (in a real app, you'd manage this state properly)
        Navigator.of(context).pop();
        final steps = [
          const ProgressStep(
            label: 'Upload',
            title: 'Uploading Data',
            description: 'Uploading case information and images...',
            icon: Icons.cloud_upload_rounded,
          ),
          const ProgressStep(
            label: 'Match',
            title: 'Matching Records',
            description: 'Searching for similar cases in the database...',
            icon: Icons.search_rounded,
          ),
          const ProgressStep(
            label: 'Notify',
            title: 'Sending Notifications',
            description: 'Alerting nearby authorities and volunteers...',
            icon: Icons.notifications_active_rounded,
          ),
          const ProgressStep(
            label: 'Complete',
            title: 'Case Submitted',
            description: 'Your case has been successfully submitted!',
            icon: Icons.check_circle_rounded,
          ),
        ];

        MultiStepProgressHelper.show(
          context: context,
          steps: steps,
          currentStep: currentStep,
          subtitle: 'Processing your case submission...',
        );

        // Continue to next step
        Future.delayed(const Duration(seconds: 2), nextStep);
      } else {
        // Complete - close dialog after a moment
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      }
    }

    // Start the progress simulation
    Future.delayed(const Duration(seconds: 2), nextStep);
  }
}
