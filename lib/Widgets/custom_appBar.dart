import 'package:flutter/material.dart';
import 'package:locat_lost/colors.dart';



class CustomAppBar extends StatelessWidget{

  final String text;
  final VoidCallback onPressed;

  CustomAppBar({
    super.key,
    required this.text,
    required this.onPressed,

  });


  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60,left: 10),
      width: 430,
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [

          IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_circle_left_rounded,color: AppColors.secondary,)),
          SizedBox(width:  90,),
          Text(text,style: TextStyle(
            fontSize: 25,
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),),
        ],
      ),
    );
  }






}