import 'package:flutter/material.dart';
import 'package:psyeasy/constants.dart';
import 'package:psyeasy/pages/addstudent.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vella,
      body: SafeArea(child: Container(
        child: Center(
          child: Text('Coming Soon..',style: PoppinsBlack,),
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed logic here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addstudent()),
            );
          },
          backgroundColor: Pacha,
          label: Text('Add Stud',style: PoppinsBlack3,),
          icon: Icon(Icons.add_moderator,color: Karp,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the value to change the corner radius
          ),
        ),
    );
  }
}