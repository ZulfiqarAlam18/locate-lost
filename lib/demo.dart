// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   final PageController _controller = PageController();
//
//   final List<Widget> splashPages = [
//     Container(
//       color: Colors.white,
//       child: const Center(child: Text('Splash Screen 1', style: TextStyle(fontSize: 24))),
//     ),
//     Container(
//       color: Colors.white,
//       child: const Center(child: Text('Splash Screen 2', style: TextStyle(fontSize: 24))),
//     ),
//     Container(
//       color: Colors.white,
//       child: const Center(child: Text('Splash Screen 3', style: TextStyle(fontSize: 24))),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _controller,
//               children: splashPages,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 30),
//             child: SmoothPageIndicator(
//               controller: _controller,
//               count: splashPages.length,
//               effect: CustomizableEffect(
//                 activeDotDecoration: DotDecoration(
//                   width: 12,
//                   height: 12,
//                   color: Colors.teal,
//                   shape: BoxShape.circle,
//                 ),
//                 dotDecoration: DotDecoration(
//                   width: 12,
//                   height: 12,
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.teal,
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
