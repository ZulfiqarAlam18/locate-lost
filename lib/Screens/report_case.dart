import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_button.dart';
import 'package:locat_lost/colors.dart';

class ReportCase extends StatefulWidget {
  const ReportCase({super.key});

  @override
  State<ReportCase> createState() => _ReportCaseState();
}

class _ReportCaseState extends State<ReportCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report a Case'),

      ),
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  Image.asset('assets/report.png',width: 355,height: 220 ,fit: BoxFit.cover,),
            ),
            SizedBox(height: 20,),
            Divider(thickness: 2,color: Colors.teal,
            indent: 80,endIndent: 80,),
            SizedBox(height: 20,),
            Text(
              'Lets reunite families with their loved ones',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20,),
            Divider(thickness: 2,color: Colors.teal,
              indent: 80,endIndent: 80,),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Container(
                  width: 170,
                  height: 205,
                //  color: Colors.teal,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.teal,
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.white),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Image.asset('assets/unlink.png',width: 40,height: 40 ,),
                            Text('Report a',style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),),
                            Text('Lost Person',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),),
                            Text('If you are looking for someone who is lost, tap here to report it.',style: TextStyle(
                              fontSize: 10,
                            ),),
                            Icon(Icons.arrow_circle_right_rounded),

                        
                        
                          ],
                        ),
                      ),
                    ),
                  ),
                ),



                InkWell(
                  onTap: () {
                    // Perform your action here
                    print("Card tapped - Report Lost Person");
                  },
                  child: Card(
                    color: Colors.teal,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      width: 170,
                      height: 205,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/unlink.png', width: 40, height: 40),
                            const SizedBox(height: 8),
                            const Text(
                              'Report a',
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              'Lost Person',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'If you are looking for someone who is lost, tap here to report it.',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            const Spacer(),
                            const Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(Icons.arrow_circle_right_rounded, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                SizedBox(width: 10,),

              ],)
          ],
        ),
      ),




    );
  }
}
