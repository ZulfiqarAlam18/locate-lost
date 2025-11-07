import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locate_lost/views/dialogs/case_submission_dialog.dart';

class DialogUtils {
  /// Show success dialog after case submission
  static void showCaseSubmissionSuccess({
    String? title,
    String? message,
    VoidCallback? onViewCases,
  }) {
    CaseSubmissionDialog.showSuccess(
      title: title,
      message: message,
      onViewCases: onViewCases,
    );
  }
  
  /// Show error dialog when case submission fails
  static void showCaseSubmissionError({
    String? title,
    String? message,
    VoidCallback? onRetry,
  }) {
    CaseSubmissionDialog.showError(
      title: title,
      message: message,
      onRetry: onRetry,
    );
  }
  
  /// Show generic success dialog
  static void showSuccess({
    String title = 'Success!',
    String message = 'Operation completed successfully.',
    Function? onOk,
  }) {
    Get.dialog(
      CaseSubmissionDialog(
        status: SubmissionStatus.success,
        customTitle: title,
        customMessage: message,
        onViewCases: onOk != null ? () => onOk() : null,
      ),
      barrierDismissible: true,
    );
  }
  
  /// Show generic error dialog
  static void showError({
    String title = 'Error',
    String message = 'Something went wrong. Please try again.',
    Function? onRetry,
  }) {
    Get.dialog(
      CaseSubmissionDialog(
        status: SubmissionStatus.error,
        customTitle: title,
        customMessage: message,
        onRetry: onRetry != null ? () => onRetry() : null,
      ),
      barrierDismissible: true,
    );
  }
}
