import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
import '../../colors.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Emergency', onPressed: (){
        Navigator.pop(context);
      }),
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      text: TextSpan(
                        text:
                        'If you ever find yourself in an emergency or a difficult situation,'
                            " don't hesitate to reach out for help. Below are important contact numbers for immediate assistance in Pakistan. Whether it's medical aid, law enforcement, "
                            'fire rescue, or protection services, '
                            'these helplines are available to support you. ',
                        style: TextStyle(
                            color: AppColors.myBlackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text:
                            'Stay safe and save these numbers for quick access!',
                            style: TextStyle(color: AppColors.myRedColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.primary,
                    endIndent: 80,
                    indent: 80,
                  ),
                  ...List.generate(5, (index) => buildExpansionCard()),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '"A strong society is one that stands together in times of need. '
                          "Helping those in distress isn't just kindness—it's our"
                          ' shared responsibility."',
                      style: TextStyle(
                        color: AppColors.myBlackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpansionCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1,
          color: AppColors.primary,
        ),
      ),
      margin: EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text(
          'What this app is about?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: AppColors.primary,
        textColor: AppColors.primary,
        collapsedTextColor: AppColors.primary,
        collapsedIconColor: AppColors.primary,
        children: [
          Container(
            width: double.infinity,
            color: Colors.teal[100],
            padding: EdgeInsets.all(16),
            child: Text(
              'Smarter Solution for reuniting missing children with their parents, with advanced AI features. LoCAT helps by utilizing modern technologies for efficient and fast reunification.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}









// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:locat_lost/Widgets/custom_appBar.dart';
// import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
// import '../../colors.dart';
//
// class EmergencyContactScreen extends StatefulWidget {
//   const EmergencyContactScreen({super.key});
//
//   @override
//   State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
// }
//
// class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           CustomAppBar(text: 'Emergency', onPressed: () {
//             Navigator.pop(context);
//           }),
//
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: RichText(text:  TextSpan(
//                       text: 'If you ever find yourself in an emergency or a difficult situation,'
//                           ' don\'t hesitate to reach out for help. Below are important contact numbers for immediate assistance in Pakistan. Whether it\'s medical aid, law enforcement, '
//                           'fire rescue, or protection services, '
//                           'these helplines are available to support you. ',style: TextStyle(color: AppColors.myBlackColor,fontSize: 12,fontWeight: FontWeight.w500),
//                       children: [
//
//                         TextSpan(
//                           text: 'Stay safe and save these numbers for quick access!',style: TextStyle(color: AppColors.myRedColor),
//                         ),
//
//                       ]
//
//                   )),
//                 ),
//                 Divider(
//                   color: AppColors.primary,
//                   endIndent: 80,
//                   indent: 80,
//                 ),
//
//                 Card(
//                   color: AppColors.primary,
//                   shape: RoundedRectangleBorder(
//
//                     borderRadius: BorderRadius.circular(12),
//                     side: BorderSide(
//                       width: 1,
//                       color: AppColors.primary,
//                     ),
//
//                   ),
//                   margin: EdgeInsets.all(10),
//                   child: ExpansionTile(
//
//
//                     title: Text('What this app is about?',style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     ),
//                     iconColor: AppColors.secondary,
//                     textColor: AppColors.secondary,
//                     collapsedTextColor: AppColors.secondary,
//                     collapsedIconColor: AppColors.secondary,
//
//
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(16),
//                           color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
//                     ],
//                     initiallyExpanded: false,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//
//                     ),
//                     collapsedShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//
//                   ),
//                 ),
//                 Card(
//                   color: AppColors.primary,
//                   shape: RoundedRectangleBorder(
//
//                     borderRadius: BorderRadius.circular(12),
//                     side: BorderSide(
//                       width: 1,
//                       color: AppColors.primary,
//                     ),
//
//                   ),
//                   margin: EdgeInsets.all(10),
//                   child: ExpansionTile(
//
//
//                     title: Text('What this app is about?',style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     ),
//                     iconColor: AppColors.secondary,
//                     textColor: AppColors.secondary,
//                     collapsedTextColor: AppColors.secondary,
//                     collapsedIconColor: AppColors.secondary,
//
//
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(16),
//                           color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
//                     ],
//                     initiallyExpanded: false,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//
//                     ),
//                     collapsedShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//
//                   ),
//                 ),
//                 Card(
//                   color: AppColors.primary,
//                   shape: RoundedRectangleBorder(
//
//                     borderRadius: BorderRadius.circular(12),
//                     side: BorderSide(
//                       width: 1,
//                       color: AppColors.primary,
//                     ),
//
//                   ),
//                   margin: EdgeInsets.all(10),
//                   child: ExpansionTile(
//
//
//                     title: Text('What this app is about?',style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     ),
//                     iconColor: AppColors.secondary,
//                     textColor: AppColors.secondary,
//                     collapsedTextColor: AppColors.secondary,
//                     collapsedIconColor: AppColors.secondary,
//
//
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(16),
//                           color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
//                     ],
//                     initiallyExpanded: false,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//
//                     ),
//                     collapsedShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//
//                   ),
//                 ),
//                 Card(
//                   color: AppColors.primary,
//                   shape: RoundedRectangleBorder(
//
//                     borderRadius: BorderRadius.circular(12),
//                     side: BorderSide(
//                       width: 1,
//                       color: AppColors.primary,
//                     ),
//
//                   ),
//                   margin: EdgeInsets.all(10),
//                   child: ExpansionTile(
//
//
//                     title: Text('What this app is about?',style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     ),
//                     iconColor: AppColors.secondary,
//                     textColor: AppColors.secondary,
//                     collapsedTextColor: AppColors.secondary,
//                     collapsedIconColor: AppColors.secondary,
//
//
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(16),
//                           color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
//                     ],
//                     initiallyExpanded: false,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//
//                     ),
//                     collapsedShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//
//                   ),
//                 ),
//                 Card(
//                   color: AppColors.primary,
//                   shape: RoundedRectangleBorder(
//
//                     borderRadius: BorderRadius.circular(12),
//                     side: BorderSide(
//                       width: 1,
//                       color: AppColors.primary,
//                     ),
//
//                   ),
//                   margin: EdgeInsets.all(10),
//                   child: ExpansionTile(
//
//
//                     title: Text('What this app is about?',style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     ),
//                     iconColor: AppColors.secondary,
//                     textColor: AppColors.secondary,
//                     collapsedTextColor: AppColors.secondary,
//                     collapsedIconColor: AppColors.secondary,
//
//
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(16),
//                           color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
//                     ],
//                     initiallyExpanded: false,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//
//                     ),
//                     collapsedShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text('"A strong society is one that stands together in times of need. '
//                       'Helping those in distress isn\'t just kindness—it\'s our'
//                       ' shared responsibility."',
//                     style: TextStyle(color: AppColors.myBlackColor,fontSize: 15,fontWeight: FontWeight.w500),),
//                 ),
//
//
//               ],
//             ),
//           ),
//
//
//
//
//
//         ],
//       ),
//     );
//   }}
//
//
//
//
//
//
//
//
//
//
//
//
//
