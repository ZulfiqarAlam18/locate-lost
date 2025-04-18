import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/Widgets/custom_elevatedButton.dart';
import '../../colors.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Frequently Asked Questions', onPressed: (){
        Navigator.pop(context);
      }),
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [

          SizedBox(height: 5),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
            
                Card(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
            
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: AppColors.primary,
                    ),
            
                  ),
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
            
            
                    title: Text('What this app is about?',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    iconColor: AppColors.secondary,
                    textColor: AppColors.secondary,
                    collapsedTextColor: AppColors.secondary,
                    collapsedIconColor: AppColors.secondary,
            
            
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                          color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
                    ],
                    initiallyExpanded: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
            
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
            
                  ),
                ),
                Card(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
            
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: AppColors.primary,
                    ),
            
                  ),
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
            
            
                    title: Text('What this app is about?',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    iconColor: AppColors.secondary,
                    textColor: AppColors.secondary,
                    collapsedTextColor: AppColors.secondary,
                    collapsedIconColor: AppColors.secondary,
            
            
                    children: [
                      Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
                    ],
                    initiallyExpanded: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
            
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
            
                  ),
                ),
                Card(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
            
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: AppColors.primary,
                    ),
            
                  ),
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
            
            
                    title: Text('What this app is about?',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    iconColor: AppColors.secondary,
                    textColor: AppColors.secondary,
                    collapsedTextColor: AppColors.secondary,
                    collapsedIconColor: AppColors.secondary,
            
            
                    children: [
                      Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
                    ],
                    initiallyExpanded: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
            
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
            
                  ),
                ),
                Card(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
            
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: AppColors.primary,
                    ),
            
                  ),
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
            
            
                    title: Text('What this app is about?',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                    iconColor: AppColors.secondary,
                    textColor: AppColors.secondary,
                    collapsedTextColor: AppColors.secondary,
                    collapsedIconColor: AppColors.secondary,
            
            
                    children: [
                      Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.white,child: Text('Smarter Solution for reuniting missing children with their parents, with advanced ai featured, LoCAT alkdfj al kdjfa ;lksjfd ;lk jfa lslfkjj alaksjd a;ldkjf a;l kjaf;ldskj fakdsfj;ak jd;lfkja ;lkf;lakjf')),
                    ],
                    initiallyExpanded: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
            
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
            
                  ),
                ),
            
            
              ],
            ),
          )),
        ],
      ),
    );
  }}













