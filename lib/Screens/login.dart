import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/Widgets/custom_textField.dart';
import 'package:locat_lost/colors.dart';

import 'home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _SignupState();
}

class _SignupState extends State<Login> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController cCNIC = TextEditingController();
  final TextEditingController cPass = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset('assets/login.jpg',width: 355,height: 280 ,),

                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont Have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                // Form with input fields and custom buttons
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: 'CNIC Number',
                        hintText: 'CNIC Number',
                        controller: cCNIC,
                        fillColor: AppColors.background,
                      ),

                      CustomTextFormField(
                        labelText: 'Password',
                        hintText: 'Password',
                        controller: cPass,
                        fillColor: AppColors.background,
                      ),
                      Container(
                        padding: EdgeInsets.only(left:215,right: 0,top: 0,bottom: 0),
                        child: TextButton(onPressed: (){
                          //Navigator.pop(context);
                        }, child: Text(
                          'forgot password?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),),


                      ),




                      // Removing extra spacing between fields
                      SizedBox(height: 15), // Only a small gap between button and fields

                      // Custom Button
                      CustomButton(
                        text: 'Log In',
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },
                        size: 'large',
                        bgColor: Colors.teal,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),





              ],
            ),
          ),
        ),
      ),
    );
  }
}
