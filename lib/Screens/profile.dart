import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:locat_lost/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // 🔷 Background Image
          Container(
            decoration: BoxDecoration(
             // color: Colors.teal,
              image: DecorationImage(
                image: AssetImage('assets/bgg.png'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // 🔷 White Card Section
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 200,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // 🔷 Profile Picture
          Positioned(
            top: 110,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(70),
              dashPattern: [8,4],
              color: Colors.teal,
              strokeWidth: 2,

              child: Card(

                shape: CircleBorder(
                  side: BorderSide(color: AppColors.primary),
                ),
                elevation: 16,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/zulfi.png'),
                ),
              ),
            ),
          ),

          // 🔷 Profile Name
          Positioned(
            top: 260,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Zulfiqar Alam',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // 🔷 Tiles (My Profile, Security, Settings)
          Positioned(
            top: 330,
            left: 20,
            right: 20,
            child: Column(
              children: [
                ListTile(

                  title: Text('My Profile'),
                  leading: Icon(Icons.person),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  iconColor: AppColors.primary,
                  textColor: AppColors.primary,
                  onTap: () {
                    // TODO: Navigate to profile page
                  },
                ),
                ListTile(
                  title: Text('Security Details'),
                  leading: Icon(Icons.security),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  iconColor: AppColors.primary,
                  textColor: AppColors.primary,
                  onTap: () {
                    // TODO: Navigate to security details
                  },
                ),
                ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  iconColor: AppColors.primary,
                  textColor: AppColors.primary,
                  onTap: () {
                    // TODO: Navigate to settings
                  },
                ),
              ],
            ),
          ),

          // back icon
          Positioned(
              top: 60,
              left: 13,

              child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_circle_left_outlined,size: 40,color: AppColors.secondary,)))
        ],
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:locat_lost/colors.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
    //
    //   backgroundColor: AppColors.secondary,
    //   body: Stack(
    //     children: [
    //
    //       //main image / bg image
    //       Container(
    //        // width: 430,
    //       //  height: 285,
    //         decoration: BoxDecoration(
    //           color: Colors.teal,
    //           image: DecorationImage(image: AssetImage('assets/bg.png',)),
    //         ),
    //
    //         alignment: Alignment.topCenter,
    //         child: Text('Profile',style: TextStyle(color: AppColors.secondary),),
    //
    //       ),
    //
    //       //rest of card ( white card)
    //       Positioned(
    //         top: 200,
    //           left: 0,
    //           right: 0,
    //
    //
    //       child: Container(
    //
    //         width: 430,
    //         height: 685,
    //
    //       //  color: Colors.teal[100],
    //         decoration: BoxDecoration(
    //           color: AppColors.secondary,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(40),
    //             topRight: Radius.circular(40),
    //           )
    //         ),
    //
    //       )),
    //
    //
    //       // Positioned(
    //       //   top: 150,
    //       //   left: MediaQuery.of(context).size.width / 2 - 90,
    //       //   child: CircleAvatar(
    //       //     radius: 90,
    //       //     backgroundColor: Colors.white,
    //       //     child: CircleAvatar(
    //       //       radius: 86.5,
    //       //       backgroundImage: AssetImage('assets/zulfi.png'), // profile pic
    //       //     ),
    //       //   ),
    //       // ),
    //       // profile picture
    //       Positioned(
    //         top: 110,
    //         left: MediaQuery.of(context).size.width / 2 - 70,
    //
    //         child: Card(
    //           shape: CircleBorder(
    //             side: BorderSide(
    //               color: AppColors.primary
    //             )
    //           ),
    //           child: CircleAvatar(
    //               radius: 70,
    //
    //             backgroundImage: AssetImage('assets/zulfi.png'),
    //
    //           ),
    //         ),
    //
    //       ),
    //       // profile name
    //       Positioned(
    //           top: 260,
    //          // left: 105,
    //           left: 0,
    //           right: 0,
    //           child: Center(
    //             child: Text('Zulfiqar Alam',
    //             style: TextStyle(
    //               fontSize: 30,
    //               color: AppColors.primary,
    //               fontWeight: FontWeight.w600,
    //             ),),
    //           )),
    //       // heading
    //       Positioned(
    //           top: 60,
    //           // left: 105,
    //           left: 10,
    //           right: 0,
    //           child: Center(
    //             child: Text('Profile',
    //               style: TextStyle(
    //                 fontSize: 30,
    //                 color: AppColors.secondary,
    //                 fontWeight: FontWeight.w500,
    //               ),),
    //           )),
    //
    //
    //       // my profile tile
    //       Positioned(
    //
    //           top: 330,
    //           child: ListTile(
    //
    //                       title: Text('My Profile'),
    //                       leading: Icon(Icons.person),
    //                       trailing: Icon(Icons.arrow_forward_ios_rounded),
    //
    //                     )
    //       ),
    //       // security details tile
    //       Positioned(
    //
    //           top: 330,
    //           child: ListTile(
    //
    //             title: Text('Security Details'),
    //             leading: Icon(Icons.security),
    //             trailing: Icon(Icons.arrow_forward_ios_rounded),
    //
    //           )
    //       ),
    //       // settings
    //       Positioned(
    //
    //           top: 330,
    //           child: ListTile(
    //
    //             title: Text('Settings'),
    //             leading: Icon(Icons.settings),
    //             trailing: Icon(Icons.arrow_forward_ios_rounded),
    //
    //           )
    //       ),
    //
    //
    //
    //
    //
    //     ],
    //   ),
    //
    //
    // );
  //}
//}
