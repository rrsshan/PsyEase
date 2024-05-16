import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psyeasy/constants.dart';

class addstudent extends StatefulWidget {
  @override
  _addstudentState createState() => _addstudentState();
}

class _addstudentState extends State<addstudent> {
  String selectedOption = '';
  String selectedOption1 = 'Pick Mentor';
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
 TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  List<String> mentorNames = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> isSelected = [false, false, false];
  //DateTime now = ;
  
  @override

    Future<String?> getMentorId(String mentorName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Mentors')
          .where('Name', isEqualTo: mentorName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
    } catch (e) {
      print("Error fetching mentor ID: $e");
    }
    return '';
  }

  Future<void> fetchMentorNames() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Mentors').get();
      List<String> names = querySnapshot.docs.map((doc) => doc['Name'] as String).toList();
      setState(() {
        mentorNames = names;
      });
    } catch (e) {
      print("Error fetching mentor names: $e");
    }
  }



final FirebaseFirestore _pdfstore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

  //File file = File('');
 final FirestoreService _firestoreService = FirestoreService();
  
  String formattedDate = "${DateTime.now().day.toString().padLeft(2, '0')}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().year.toString()}";


  void initState() {
    super.initState();
    _textEditingController1.text = selectedOption;
    _textEditingController2.text = selectedOption1;
    //super.initState();
    fetchMentorNames();

  }

   
    //User? _currentUser = auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vella,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Vella
        ),
        centerTitle: true,
        backgroundColor: Karp,
        title: Text('Add Note To The DataBase',style: PoppinsWhite8,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                                readOnly: false,
                                controller: _textEditingController1,
                                style: PoppinsBlack3,
                                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '',
                  hintStyle: PoppinsBlack3,
                  labelText: 'Name',
                  labelStyle: PoppinsBlack3
                                ),
                              ),
                ),
            

              ],
            ),
                        SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                                readOnly: true,
                                controller: _textEditingController,
                                style: PoppinsBlack3,
                                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: 'Semester',
                  hintStyle: PoppinsBlack3,
                  labelText: 'Semester',
                  labelStyle: PoppinsBlack3
                                ),
                              ),
                ),
            PopupMenuButton(
              color: Vella,
              iconColor: Karp,
              onSelected: (value) {
                setState(() {
                  selectedOption = value;
                  _textEditingController.text = selectedOption;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: '1',
                  child: Text('S1',style: PoppinsBlack3,),
                ),
                PopupMenuItem(
                  value: '2',
                  child: Text('S2',style: PoppinsBlack3,),
                ),
                PopupMenuItem(
                  value: '3',
                  child: Text('S3',style: PoppinsBlack3,),
                ),
                PopupMenuItem(
                  value: '4',
                  child: Text('S4',style: PoppinsBlack3,),
                ),
                PopupMenuItem(
                  value: '5',
                  child: Text('S5',style: PoppinsBlack3,),
                ),
                PopupMenuItem(
                  value: '6',
                  child: Text('S6',style: PoppinsBlack3,),
                ),
              ],
            ),

              ],
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                                readOnly: true,
                                controller: _textEditingController2,
                                style: PoppinsBlack3,
                                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // hintText: 'Select Subject',
                  // hintStyle: PoppinsBlack3,
                  labelText: 'Mentor',
                  labelStyle: PoppinsBlack3
                                ),
                              ),
                ),
            PopupMenuButton(
              color: Vella,
              surfaceTintColor: Vella,
              iconColor: Karp,
              onSelected: (value) {
                setState(() {
                  selectedOption1 = value;
                  _textEditingController2.text = selectedOption1;
                });
              },
                      itemBuilder: (BuildContext context) {
          return mentorNames.map((String name) {
            return PopupMenuItem<String>(
              value: name,
              child: Text(name),
            );
          }).toList();
        },
            ),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            
            //Text('Psyhology',style: PoppinsBlack,),
            SizedBox(width: 30,),
            Align(
              alignment: Alignment.center,
              child: ToggleButtons(
              
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Psychology',style: PoppinsBlack,),
                              Icon(Icons.done)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Statistics',style: PoppinsBlack,),
                              Icon(Icons.done)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Physiology',style: PoppinsBlack,),
                              Icon(Icons.done)
                            ],
                          ),
                        ),
                      ],
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });
                      },
                    ),
            ),
             SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                 onPressed: () async {
              
             String? mentorId = await getMentorId(_textEditingController2.text);
              Student student = Student(name: _textEditingController1.text, semester: _textEditingController.text, mentorId: mentorId,isSelected: isSelected);
              //Student(name: name, semester: semester, mentorId: mentorId, isSelected: isSelected);
              _firestoreService.addStudent(student);

              await Future.delayed(Duration(seconds: 1));

                // Show success message
                final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Karp, // Background color
                foregroundColor: Vella, // Text color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 4, // Shadow
              ),
              child: Text('Upload Now!', style: PoppinsWhite),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController1.dispose();
    _textEditingController2.dispose();

    super.dispose();
  }
  
}

class Student {
  final String name;
  final String semester;
  final String? mentorId;
  final List<bool> isSelected;


  Student({required this.name, required this.semester, required this.mentorId,required this.isSelected});

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Semester': semester,
      'MentorId': mentorId,
      'Psychology' : isSelected[0],
      'Statistics' : isSelected[1],
      'Physiology' : isSelected[2],
    };
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addStudent(Student student) {
    return _db.collection('Students').add(student.toMap());
  }
}