import 'package:flutter/material.dart';
import 'package:locat_lost/Screens/parent_screens/parent_info.dart' show ParentDetailsScreen;
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/Widgets/custom_textField.dart';
import 'package:locat_lost/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UploadImagesScreen extends StatefulWidget {
  const UploadImagesScreen({super.key});

  @override
  State<UploadImagesScreen> createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> {


  double progressPercent = .65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        
            children: [
        
              SizedBox(height: 50),
              Center(child: Text(
                'Lost Person',
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),),
        
              Divider(
                color: AppColors.primary,
                indent: 100,
                endIndent: 100,
                thickness: 2,
              ),
              SizedBox(height: 20),
        
        
              Container(
                width: 390,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                child: Card(
                  elevation: 6,
                  color: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Application Progress',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Enter missing person\'s real\nname to continue',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.myRedColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:
        
        
                          CircularPercentIndicator(
                            radius: 40,
                            lineWidth: 8.0,
                            percent: progressPercent,
                            animation: true,
                            animationDuration: 1000,
                            progressColor: AppColors.primary,
                            backgroundColor: Colors.teal.shade100,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              "${(progressPercent * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[800],
                              ),
                            ),
                          ),
        
        
        
        
        
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        
        
        
              SizedBox(height: 20),
              Divider(
                color: AppColors.primary,
                indent: 100,
                endIndent: 100,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Text(
                'Upload clear and front facing images/videos of the missing person.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.myBlackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 430,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                child: Card(
        
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                    child: Column(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.upload,color: AppColors.primary,size: 49,)),
                        Text('Upload Image',style: TextStyle(
                          fontSize: 20,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(height: 10,),
        
                        Text('YOU MUST UPLOAD AT LEAST ONE IMAGE/VIDEO OF THE PERSON',style: TextStyle(
                          fontSize: 10,
                          color: AppColors.myRedColor,
                          fontWeight: FontWeight.w300,
                        ),),
                        SizedBox(height: 10,),
                        Text('(Image/video size shouldn’t be more than 10 MBs.)',style: TextStyle(
                          fontSize: 12,
                          color: AppColors.myRedColor,
                          fontWeight: FontWeight.w300,
                        ),),
                      ],
                    )
        
        
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 430,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                child: Card(
        
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                      child: Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt,color: AppColors.primary,size: 49,)),
                          Text('Upload Video',style: TextStyle(
                            fontSize: 20,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),),
                          SizedBox(height: 10,),
        
                          Text('(Optional)',style: TextStyle(
                            fontSize: 10,
                            color: AppColors.myRedColor,
                            fontWeight: FontWeight.w300,
                          ),),
                          SizedBox(height: 10,),
                          Text('(Image/video size shouldn’t be more than 10 MBs.)',style: TextStyle(
                            fontSize: 12,
                            color: AppColors.myRedColor,
                            fontWeight: FontWeight.w300,
                          ),),
                        ],
                      )
        
        
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.primary,
                      size: 'small',
                      label: 'Back',
                      border: true),
                  CustomButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ParentDetailsScreen()));

                  },
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.secondary,
                      size: 'small',
                      label: 'Next',
                      border: true),





                ],
              ),

        
            ],
          ),
        ),
      ),
    );

  }

}


























