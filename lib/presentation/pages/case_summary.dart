// This file is deprecated - use parent_case_summary.dart or finder_case_summary.dart instead
// Keeping for backward compatibility

import 'package:flutter/material.dart';
import 'parent_case_summary.dart';
import 'finder_case_summary.dart';

class CaseSummaryScreen extends StatelessWidget {
  final String? userType; // 'parent' or 'finder'

  const CaseSummaryScreen({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    // Redirect to appropriate summary screen based on user type
    if (userType == 'finder') {
      return const FinderCaseSummaryScreen();
    } else {
      return const ParentCaseSummaryScreen();
    }
  }
}
