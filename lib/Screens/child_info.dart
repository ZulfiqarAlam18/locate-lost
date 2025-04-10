import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/Widgets/custom_textField.dart';
import 'package:locat_lost/colors.dart';

class ChildDetailsScreens extends StatefulWidget {
  const ChildDetailsScreens({super.key});

  @override
  State<ChildDetailsScreens> createState() => _ChildDetailsScreensState();
}

class _ChildDetailsScreensState extends State<ChildDetailsScreens> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController cName = TextEditingController();
  final TextEditingController cFName = TextEditingController();
  final TextEditingController cCaste = TextEditingController();
  final TextEditingController cGender = TextEditingController();
  final TextEditingController cHeight = TextEditingController();
  final TextEditingController cHairColor = TextEditingController();
  final TextEditingController cSkinColor = TextEditingController();
  final TextEditingController cDisability = TextEditingController();
  final TextEditingController cLastSeenPlace = TextEditingController();
  final TextEditingController cLastSeenTime = TextEditingController();
  final TextEditingController cNum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          SizedBox(height: 80,),
          Text(
            'Lost Person',
            style: TextStyle(
              fontSize: 25,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(
            color: AppColors.primary,
            indent: 100,
            endIndent: 100,
            thickness: 2,
          ),
          SizedBox(height: 20,),
          Container(
            width: 390,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              elevation: 16,
              color: Colors.teal[100],

              child: Row(

                children: [
                  Column(
                    children: [
                      Text('Application Progress',style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      Text('Enter missing person\'s real\n name here',style: TextStyle(
                        fontSize: 14,
                        color: AppColors.myRedColor,
                        fontWeight: FontWeight.w300,
                      ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40,),
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColors.myRedColor,
                    child: Text('25%',style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    ),),

                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Divider(
            color: AppColors.primary,
            indent: 100,
            endIndent: 100,
            thickness: 2,
          ),
          SizedBox(height: 10,),
          Text(
            'Please complete the form with the accurate details of the missing person',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.myBlackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            'Personal Details:',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10,),

          Expanded(
            child: Form(
              key: _key,

              child: Column(
                children: [
                  //name
                  RichText(
                    text: TextSpan(
                      text: 'Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Name',
                    hintText: 'Enter Missing Person\'s name',
                    controller: cName,
                  ),

                  //father name
                  RichText(
                    text: TextSpan(
                      text: 'Father\'s name:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: '',
                    hintText: 'Enter Missing Person\'s father\'s name',
                    controller: cFName,
                  ),

                  //surname
                  RichText(
                    text: TextSpan(
                      text: 'Surname:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: '',
                    hintText: 'Enter Missing Person\'s surname',
                    controller: cCaste,
                  ),

                  //gender
                  RichText(
                    text: TextSpan(
                      text: 'Gender',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: '',
                    hintText: 'Enter Missing Person\'s Gender',
                    controller: cGender,
                  ),
                  //height
                  RichText(
                    text: TextSpan(
                      text: 'Height:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: '',
                    hintText: 'Enter Missing Person\'s heigh(ft)',
                    controller: cHeight,
                  ),

                  //skin color
                  RichText(
                    text: TextSpan(
                      text: 'Skin Color:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Skin Color',
                    hintText: 'Enter Missing Person\'s skin color',
                    controller: cSkinColor,
                  ),

                  //hair color
                  RichText(
                    text: TextSpan(
                      text: 'Hair Color:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Hair Color',
                    hintText: 'Enter Missing Person\'s Hair Color:',
                    controller: cHairColor,
                  ),

                  // Disability
                  RichText(
                    text: TextSpan(
                      text: 'Disability(if any) :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Disability',
                    hintText: 'Enter Missing Person\'s disability',
                    controller: cDisability,
                  ),

                  //last seen place
                  RichText(
                    text: TextSpan(
                      text: 'Last Seen Place:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: '',
                    hintText: 'Where was the person seen last time',
                    controller: cLastSeenPlace,
                  ),

                  // last seen time
                  RichText(
                    text: TextSpan(
                      text: 'Last seen Time:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Enter name',
                    hintText: 'Enter Missing Person\'s name',
                    controller: cLastSeenTime,
                  ),

                  //phone number
                  RichText(
                    text: TextSpan(
                      text: 'Phone Number (optional):',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: '',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Enter name',
                    hintText: 'Enter Missing Person\'s phone number',
                    controller: cName,
                  ),

                  Row(
                    children: [
                      CustomButton(
                        text: 'Back',
                        onPressed: () {},
                        size: 'small',
                        bgColor: AppColors.secondary,
                        textColor: AppColors.primary,
                      ),
                      CustomButton(
                        text: 'Next',
                        onPressed: () {},
                        size: 'small',
                        bgColor: AppColors.primary,
                        textColor: AppColors.secondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
