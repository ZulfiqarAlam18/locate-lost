import 'package:flutter/material.dart';

class Spalsh1 extends StatefulWidget {
  const Spalsh1({super.key});

  @override
  State<Spalsh1> createState() => _Spalsh1State();
}

class _Spalsh1State extends State<Spalsh1> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(

          children: [

            Text('Locate Lost'),
            Divider(),

            ElevatedButton(onPressed: (){}, child: const Text('Get Started'))

          ],

        ),
      ),

    );

  }
}
