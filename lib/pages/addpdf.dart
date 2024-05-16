import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psyeasy/constants.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String selectedOption = 'Select Subject';
  String selectedOption1 = 'Select Semester';
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
 TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  //DateTime now = ;
  
  @override

final FirebaseFirestore _pdfstore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

  File file = File('');

  
  String formattedDate = "${DateTime.now().day.toString().padLeft(2, '0')}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().year.toString()}";

Future<String> upload (String filename,File file) async {
    final referance = FirebaseStorage.instance.ref().child("Notes/$selectedOption/$filename.pdf");
    final uploadTask = referance.putFile(file);
    await uploadTask.whenComplete(() => (){
      showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Vella,
                        title: Text('Confirmation',style: PoppinsBlack3,),
                        content: Text('Upload completed. Do you want to continue?',style: PoppinsBlack3,),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // TODO: Add your action here
                              Navigator.of(context).pop();
                            },
                            child: Text('No',style: PoppinsBlack3,),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Add your action here
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes',style: PoppinsBlack3,),
                          ),
                        ],
                      ); },
                  );
    });
    final downloadlink = await referance.getDownloadURL();
    return downloadlink;
  }


void pick () async {
      final pickedfile = await FilePicker.platform.pickFiles(
        type: FileType.custom,allowedExtensions: ['pdf'],
      );
      if(pickedfile!=null){
        setState(() {
          _textEditingController2.text = pickedfile.files[0].name;
          _textEditingController3.text = pickedfile.files[0].path!;
           file = File(pickedfile.files[0].path!);
        });
        // String filename = pickedfile.files[0].name;
        // File file = File();

        
      }
    }

  void initState() {
    super.initState();
    _textEditingController.text = selectedOption;
    _textEditingController1.text = selectedOption1;


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
            
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                                readOnly: true,
                                controller: _textEditingController,
                                style: PoppinsBlack3,
                                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select Subject',
                  hintStyle: PoppinsBlack3,
                  labelText: 'Pick One',
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
                  selectedOption = value;
                  _textEditingController.text = selectedOption;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: 'Psychology',
                  child: Text('Psychology',style: PoppinsBlack3,),
                ),
                PopupMenuItem(
                  value: 'Statistics',
                  child: Text('Statistics',style: PoppinsBlack3,),
                ),
                PopupMenuItem(
                  value: 'Physiology',
                  child: Text('Physiology',style: PoppinsBlack3,),
                ),
              ],
            ),

              ],
            ),
            // SizedBox(height: 20),
            
            // SizedBox(height: 10),
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextFormField(
            //                     readOnly: true,
            //                     controller: _textEditingController1,
            //                     style: PoppinsBlack3,
            //                     decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintText: 'Select Semester',
            //       hintStyle: PoppinsBlack3,
            //       labelText: 'Selected Option',
            //       labelStyle: PoppinsBlack3
            //                     ),
            //                   ),
            //     ),
            // PopupMenuButton(
            //   color: Vella,
            //   iconColor: Karp,
            //   onSelected: (value) {
            //     setState(() {
            //       selectedOption1 = value;
            //       _textEditingController1.text = selectedOption1;
            //     });
            //   },
            //   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            //     PopupMenuItem(
            //       value: 'S1',
            //       child: Text('S1',style: PoppinsBlack3,),
            //     ),
            //     PopupMenuItem(
            //       value: 'S2',
            //       child: Text('S2',style: PoppinsBlack3,),
            //     ),
            //     PopupMenuItem(
            //       value: 'S3',
            //       child: Text('S3',style: PoppinsBlack3,),
            //     ),
            //     PopupMenuItem(
            //       value: 'S4',
            //       child: Text('S4',style: PoppinsBlack3,),
            //     ),
            //     PopupMenuItem(
            //       value: 'S5',
            //       child: Text('S5',style: PoppinsBlack3,),
            //     ),
            //     PopupMenuItem(
            //       value: 'S6',
            //       child: Text('S6',style: PoppinsBlack3,),
            //     ),
            //   ],
            // ),

            //   ],
            // ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                                readOnly: true,
                                controller: _textEditingController2,
                                style: PoppinsBlack3,
                                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                 
                  labelText: 'Pick Notes',
                  labelStyle: PoppinsBlack3
                                ),
                              ),
                ),
            IconButton(onPressed: pick, icon: Icon(Icons.attach_file,color: Karp,))

              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                                readOnly: true,
                                controller: _textEditingController3,
                                style: PoppinsBlack3,
                                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                 
                  labelText: 'File Path',
                  labelStyle: PoppinsBlack3
                                ),
                              ),
                ),
            IconButton(onPressed: () async {
              showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Vella,
                        title: Text('Confirmation',style: PoppinsBlack3,),
                        content: Text('Do you want to continue?',style: PoppinsBlack3,),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // TODO: Add your action here
                              Navigator.of(context).pop();
                            },
                            child: Text('No',style: PoppinsBlack3,),
                          ),
                          TextButton(
                            onPressed: () async {
                              // TODO: Add your action here
                              final downloadlink = await upload(_textEditingController2.text, file);
              await _pdfstore.collection("Notes").add({
          "Name" : _textEditingController2.text,
          "url" :downloadlink,
          "Date Added": formattedDate,
          "Added By" : auth.currentUser!.email.toString().toUpperCase().substring(0, auth.currentUser!.email.toString().length - 10),
   
        });
                            },
                            child: Text('Yes',style: PoppinsBlack3,),
                          ),
                        ],
                      ); },
                  );
              
            }, icon: Icon(Icons.upload_file,color: Colors.black,))

              ],
            ),
          
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController1.dispose();

    super.dispose();
  }
}