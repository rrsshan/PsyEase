import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psyeasy/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psyeasy/notes/repo.dart';
import 'package:psyeasy/pages/addpdf.dart';
import 'package:psyeasy/pages/chat.dart';
import 'package:psyeasy/pages/datas.dart';
import 'package:psyeasy/pages/hometemp.dart';
import 'package:psyeasy/pages/students.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

 final List<Widget> _children = [datas(),ChatScreen(),];
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _pdfstore = FirebaseFirestore.instance;

   final CollectionReference player = FirebaseFirestore.instance.collection('Notes');

  String name = '';

  int _selectedIndex = 0;
  String formattedDate = "${DateTime.now().day.toString().padLeft(2, '0')}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().year.toString()}";

  Future<String> upload (String filename,File file) async {
    final referance = FirebaseStorage.instance.ref().child("Notes/$filename.pdf");
    final uploadTask = referance.putFile(file);
    await uploadTask.whenComplete(() => null);
    final downloadlink = await referance.getDownloadURL();
    return downloadlink;
  }

    void pick () async {
      final pickedfile = await FilePicker.platform.pickFiles(
        type: FileType.custom,allowedExtensions: ['pdf'],
      );
      if(pickedfile!=null){
        String filename = pickedfile.files[0].name;
        File file = File(pickedfile.files[0].path!);
        final downloadlink = await upload(filename, file);
        await _pdfstore.collection("Notes").add({
          "Name" : filename,
          "url" :downloadlink,
          "Date Added": formattedDate,
          "Creator" : auth.currentUser!.email!.toUpperCase().substring(0, auth.currentUser!.email!.toUpperCase().length - 9),
        });
      }
    }
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;


    return Scaffold(
      appBar: AppBar(
        title: Text('Administrator',style: PoppinsWhite,),
        backgroundColor: Karp,
        leading:
          IconButton(
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => students()),
            );
          }, 
          icon: Icon(Icons.view_list,color: Vella,size: 30,)),
        ),
        body: _children[_selectedIndex],
        
      backgroundColor: Vella,
              bottomNavigationBar: BottomNavigationBar(
                selectedFontSize: 12,
                unselectedIconTheme: IconThemeData(
                  color: Karp
                ),
                selectedIconTheme: IconThemeData(
                  color: Colors.black
                ),
                backgroundColor: Vella,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined,),
            label: 'Database',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt,),
            label: 'Mentoring',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

