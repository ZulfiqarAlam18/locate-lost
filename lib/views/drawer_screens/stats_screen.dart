import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/colors.dart';

class StatsScreen extends StatelessWidget {
  // Sample data - replace with your actual data
  final stats = {
    'Total Cases': 1243,
    'Closed Cases': 876,
    'Pending Cases': 367,
    'Success Rate': '87.5%',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: CustomAppBar(text: 'Stats', onPressed: (){

        Navigator.pop(context);

      }),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildStatsGrid(),
            SizedBox(height: 20),
            _buildSuccessRate(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Reuniting Missing Children',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: stats.entries.map((entry) {
        return Card(
          elevation: 2,
          color: Colors.teal.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.value.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuccessRate() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Success Rate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(
              value: 0.875, // 87.5%
              strokeWidth: 10,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            SizedBox(height: 10),
            Text(
              '${stats['Success Rate']} of cases resolved successfully',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}