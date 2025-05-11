import 'package:flutter/material.dart';
import 'package:locat_lost/views/auth_screens/forgot_password_screen.dart';
import 'package:locat_lost/views/auth_screens/signup_screen.dart';
import 'package:locat_lost/widgets/custom_text_field.dart';
import 'package:locat_lost/utils/app_colors.dart';
import '../../widgets/custom_elevated_button.dart';
import '../home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Image.asset('assets/images/login.jpg',width: 355,height: 280 ,),

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
                      'Don\'t Have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
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
                        padding: EdgeInsets.only(left:195,right: 0,top: 0,bottom: 0),
                        child: TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
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
                      CustomElevatedButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                      },
                        height: 60,
                        width: 241,
                        fontSize: 20,
                        borderRadius: 10,
                        label: 'Log In',
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
