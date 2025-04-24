import 'package:flutter/material.dart';
import 'package:locat_lost/Screens/display_info.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/colors.dart';

import 'parent_screens/child_info.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'LocateLost', onPressed: (){}),
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          // AppBar-style top container


          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.teal,),style: IconButton.styleFrom(
                side: BorderSide(color: Colors.teal),
              ),),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: () {}, child: const Text('All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal,
                  side: BorderSide(
                    color: Colors.teal,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: () {}, child: const Text('Lost'), style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                side: BorderSide(
                  color: Colors.teal,
                ),
              ),),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: () {}, child: const Text('Found'), style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                side: BorderSide(
                  color: Colors.teal,
                ),
              ),),
            ],
          ),

          const Divider(color: Colors.teal,),

          // ListView
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1,color: Colors.teal),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: ClipRRect(borderRadius: BorderRadius.circular(30),child: Image.asset('assets/zulfi.png',fit: BoxFit.cover,)),
                    ),
                    title: const Text('Zulfiqar Alam'),
                    subtitle: const Text('Reported Case Detail'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayInfoScreen()));
                    },
                  ),
                );
              },
            ),
          ),


          // Buttons row

        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChildDetailsScreens()));

      },child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.teal,),
    );
  }
}
