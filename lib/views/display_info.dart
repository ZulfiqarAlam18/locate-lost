import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
import 'package:locat_lost/colors.dart';
import 'package:locat_lost/demo.dart';

import '../Widgets/custom_appBar.dart';
import '../Widgets/custom_elevated_button.dart';
import 'auth_screens/login.dart';

class DisplayInfoScreen extends StatefulWidget {
  const DisplayInfoScreen({super.key});

  @override
  State<DisplayInfoScreen> createState() => _DisplayInfoScreenState();
}

class _DisplayInfoScreenState extends State<DisplayInfoScreen> {
  @override
  Widget build(BuildContext context) {
    // Dummy data (can be fetched dynamically from backend)
    final List<String> dummyImages = [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/140',
      'https://via.placeholder.com/130',
    ];

    final Map<String, String> childDetails = {
      'Name': 'Ali Khan',
      'Age': '6',
      'Gender': 'Male',
      'Clothes': 'Blue Shirt, Black Jeans',
      'Location': 'Lahore Cantt',
    };

    final Map<String, String> parentDetails = {
      'Name': 'Mr. Khan',
      'Phone': '0300-1234567',
      'CNIC': '35201-1234567-1',
    };

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: CustomAppBar(
        text: 'Missing Child Details',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Uploaded Child Images:', style: sectionTitle()),

            const SizedBox(height: 10),

            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 140,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.primary),
                      image: DecorationImage(
                        image: NetworkImage(dummyImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Divider(color: AppColors.primary, thickness: 1.5),

            Text('Child Details:', style: sectionTitle()),

            const SizedBox(height: 10),

            ..._buildInfoList(childDetails),

            const SizedBox(height: 20),

            Divider(color: AppColors.primary, thickness: 1.5),

            Text('Parent Info:', style: sectionTitle()),

            const SizedBox(height: 10),

            ..._buildInfoList(parentDetails),

            const SizedBox(height: 30),

            Center(
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                height: 45,
                width: 130,
                fontSize: 15,
                borderRadius: 10,
                label: 'Edit Details',
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInfoList(Map<String, String> data) {
    return data.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.circle, size: 8, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '${entry.key}: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: entry.value,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  TextStyle sectionTitle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
// import 'package:locat_lost/colors.dart';
// import 'package:locat_lost/demo.dart';
//
// import '../Widgets/custom_appBar.dart';
//
// class DisplayInfoScreen extends StatefulWidget {
//   const DisplayInfoScreen({super.key});
//
//   @override
//   State<DisplayInfoScreen> createState() => _DisplayInfoScreenState();
// }
//
// class _DisplayInfoScreenState extends State<DisplayInfoScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // Dummy data
//     final List<String> dummyImages = [
//       'https://via.placeholder.com/150',
//       'https://via.placeholder.com/140',
//       'https://via.placeholder.com/130',
//     ];
//
//     final Map<String, String> childDetails = {
//       'Name': 'Ali Khan',
//       'Age': '6',
//       'Gender': 'Male',
//       'Clothes': 'Blue Shirt, Black Jeans',
//       'Location': 'Lahore Cantt',
//     };
//
//     final Map<String, String> parentDetails = {
//       'Name': 'Mr. Khan',
//       'Phone': '0300-1234567',
//       'CNIC': '35201-1234567-1',
//     };
//
//     return Scaffold(
//
//       backgroundColor: AppColors.secondary,
//
//       appBar: CustomAppBar(text: 'Missing Child Details', onPressed: (){
//         Navigator.pop(context);
//       }),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Uploaded Child Images:', style: sectionTitle()),
//
//             const SizedBox(height: 10),
//
//             SizedBox(
//               height: 180,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: dummyImages.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.only(right: 10),
//                     width: 140,
//                     height: 180,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: AppColors.primary),
//                       image: DecorationImage(
//                         image: NetworkImage(dummyImages[index]),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             Divider(color: AppColors.primary, thickness: 1.5),
//
//             Text('Child Details:', style: sectionTitle()),
//
//             const SizedBox(height: 10),
//
//             ..._buildInfoList(childDetails),
//
//             const SizedBox(height: 20),
//
//             Divider(color: AppColors.primary, thickness: 1.5),
//
//             Text('Parent Info:', style: sectionTitle()),
//
//             const SizedBox(height: 10),
//
//             ..._buildInfoList(parentDetails),
//
//             const SizedBox(height: 30),
//
//             Center(
//               child: CustomElevatedButton(
//                 label: 'Edit Details',
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: AppColors.secondary,
//                 width: 130,
//                 height: 50,
//                 onPressed: () {},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildInfoList(Map<String, String> data) {
//     return data.entries.map((entry) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.circle, size: 8, color: Colors.grey),
//             const SizedBox(width: 8),
//             Expanded(
//               child: RichText(
//                 text: TextSpan(
//                   text: '${entry.key}: ',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: entry.value,
//                       style: const TextStyle(fontWeight: FontWeight.normal),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }).toList();
//   }
//
//   TextStyle sectionTitle() {
//     return const TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.bold,
//       color: Colors.teal,
//     );
//   }
// }
