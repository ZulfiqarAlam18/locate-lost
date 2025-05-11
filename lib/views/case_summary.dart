import 'package:flutter/material.dart';
import 'package:locat_lost/widgets/custom_app_bar.dart';

import '../utils/app_colors.dart';
import 'display_info_screen.dart';
import 'parent_screens/missing_person_details.dart';

class CaseSummaryScreen extends StatefulWidget {
  const CaseSummaryScreen({super.key});

  @override
  State<CaseSummaryScreen> createState() => _CaseSummaryScreenState();
}

class _CaseSummaryScreenState extends State<CaseSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'LocateLost',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Case Summary',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 2,
              color: AppColors.primary,
              indent: 80,
              endIndent: 80,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Case Information'),
                    _buildInfoCard(
                      'Case Type: Missing Person',
                      'Status: Active',
                      'Case ID: ML-2023-0042',
                      'Reported on: ${DateTime.now().toString().substring(0, 10)}',
                    ),
                    _buildSectionTitle('Person Details'),
                    _buildInfoCard(
                      'Name: John Doe',
                      'Age: 25',
                      'Gender: Male',
                      'Last Seen: Central Park, New York',
                    ),
                    _buildSectionTitle('Contact Information'),
                    _buildInfoCard(
                      'Reporter: Jane Doe',
                      'Relationship: Sister',
                      'Phone: +1 234 567 8901',
                      'Email: jane.doe@example.com',
                    ),
                    const SizedBox(height: 20),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String line1, String line2, String line3, String line4) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.primary.withOpacity(0.5), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(line1, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(line2, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(line3, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(line4, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MissingPersonDetailsScreen(),
              ),
            );
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit Case'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DisplayInfoScreen(),
              ),
            );
          },
          icon: const Icon(Icons.check_circle),
          label: const Text('Submit Case'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
