import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String size;
  final Color? bgColor;
  final Color? textColor;

  const CustomButton({
   super.key,
   required this.text,
   required this.onPressed,
   required this.size,

   // this.size = 'small',
   required this.bgColor,
   required this.textColor,


});



  @override
  Widget build(BuildContext context) {
    double width = size == 'large' ? 240 : 60;
    double height = size == 'large' ? 60 : 40;


    return SizedBox(
      width: width,
      height: height,

      child: ElevatedButton(onPressed: onPressed, child: Text(text,),style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? Colors.teal,
        foregroundColor: textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )



      )),

    );




  }
}
