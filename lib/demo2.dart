import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("•", style: TextStyle(fontSize: 20)),
              SizedBox(width: 6), // spacing between bullet and text
              Expanded(
                child: Text("This is the first bullet point."),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("•", style: TextStyle(fontSize: 20)),
              SizedBox(width: 6),
              Expanded(
                child: Text("This is the second bullet point."),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("•", style: TextStyle(fontSize: 20)),
              SizedBox(width: 6),
              Expanded(
                child: Text("And here's the third one."),
              ),
            ],
          ),
        ],
      )
      ,
    );
  }
}
