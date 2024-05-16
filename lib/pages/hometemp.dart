import 'package:flutter/material.dart';
import 'package:psyeasy/constants.dart';

class hometemp extends StatefulWidget {
  const hometemp({super.key});

  @override
  State<hometemp> createState() => _hometempState();
}

class _hometempState extends State<hometemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vella,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed logic here
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyWidget()),
            // );
          },
          backgroundColor: Karp,
          label: Text('Student List',style: PoppinsWhite2,),
          icon: Icon(Icons.analytics_outlined,color: Vella,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the value to change the corner radius
          ),
        ),
    );
  }
}