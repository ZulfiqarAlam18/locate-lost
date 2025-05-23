import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Add this package

import '../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';

class StatsScreen extends StatelessWidget {
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
      appBar: CustomAppBar(
        text: 'Stats',
        onPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Reuniting Missing Children',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: stats.entries
                  .where((entry) => entry.key != 'Success Rate')
                  .map((entry) => _buildStatCard(entry.key, entry.value.toString(), context))
                  .toList(),
            ),
            const SizedBox(height: 32),
            _buildSuccessRateCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(2, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessRateCard(BuildContext context) {
    double successRate = 0.875;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 16),
            CircularPercentIndicator(
              radius: 70.0,
              lineWidth: 12.0,
              percent: successRate,
              center: Text(
                '${(successRate * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              progressColor: AppColors.primary,
              backgroundColor: Colors.grey.shade200,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
            ),
            const SizedBox(height: 12),
            Text(
              '${stats['Success Rate']} of cases resolved successfully',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}












// import 'package:flutter/material.dart';
//
// import '../../utils/app_colors.dart';
// import '../../widgets/custom_app_bar.dart';
//
// class StatsScreen extends StatelessWidget {
//   // Sample data - replace with your actual data
//   final stats = {
//     'Total Cases': 1243,
//     'Closed Cases': 876,
//     'Pending Cases': 367,
//     'Success Rate': '87.5%',
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       appBar: CustomAppBar(text: 'Stats', onPressed: (){
//
//         Navigator.pop(context);
//
//       }),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildHeader(),
//             SizedBox(height: 20),
//             _buildStatsGrid(),
//             SizedBox(height: 20),
//             _buildSuccessRate(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Text(
//       'Reuniting Missing Children',
//       style: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: AppColors.primary,
//       ),
//       textAlign: TextAlign.center,
//     );
//   }
//
//   Widget _buildStatsGrid() {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       childAspectRatio: 1.5,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       children: stats.entries.map((entry) {
//         return Card(
//           elevation: 2,
//           color: Colors.teal.withOpacity(0.1),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   entry.value.toString(),
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primary,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   entry.key,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black87,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildSuccessRate() {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'Success Rate',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.primary,
//               ),
//             ),
//             SizedBox(height: 10),
//             CircularProgressIndicator(
//               value: 0.875, // 87.5%
//               strokeWidth: 10,
//               backgroundColor: Colors.grey[200],
//               valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
//             ),
//             SizedBox(height: 10),
//             Text(
//               '${stats['Success Rate']} of cases resolved successfully',
//               style: TextStyle(color: Colors.black87),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }