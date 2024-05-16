import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:psyeasy/constants.dart';
import 'package:psyeasy/pages/addpdf.dart';

class datas extends StatefulWidget {
  const datas({super.key});

  @override
  State<datas> createState() => _datasState();
}

class _datasState extends State<datas> {
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
  @override
  Widget build(BuildContext context) {
     final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Vella,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed logic here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyWidget()),
            );
          },
          backgroundColor: Pacha,
          label: Text('Add Note',style: PoppinsBlack3,),
          icon: Icon(Icons.note_add,color: Karp,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the value to change the corner radius
          ),
        ),
      body:  SafeArea(
        child: StreamBuilder(
          stream: player.orderBy('Date Added').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return 
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var playerSnap =
                          snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  
                      return !playerSnap['Name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(name.toLowerCase()) &&
                              name.isNotEmpty
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                  // Navigate to detailed page when item is tapped
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DetailPage(item: playerSnap)),
                  // );
                  },
                                child: Container(
                                  width: screenWidth,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Vella,
                                      border: Border.all(
                                        color: Colors.black,width: 1
                                      )
                                      ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                playerSnap['Date Added'].toString(),
                                                style: PoppinsBlack1,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Icon(Icons.topic,color: Karp,),
                                                SizedBox(width: 12,),
                                                Container(
                                                  width: screenWidth-120,
                                                  child: Text(
                                                    
                                                    playerSnap['Name'],
                                                    style:  PoppinsBlack2,
                                                    maxLines: 2, // Limit the number of lines to 1
                                                    overflow: TextOverflow.ellipsis,
                                                        
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              color: Colors.black,
                                              height: 1,
                                              width: screenWidth-50,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(Icons.person,color: Karp,),
                                                SizedBox(width: 12,),
                                                Text(
                                                  playerSnap['Creator'],
                                                  style:  PoppinsBlack
                                                ),
                                                //Align(child: Icon(Icons.delete_outline,color: Karp,),alignment: Alignment.centerRight,)
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                
              );
            }
            return Container();
          },
          ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {

  Map<String, dynamic>  item = Map<String, dynamic>();

  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vella,
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5,),
                Text('${item['title']}',style: PoppinsWhite9,textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Text('${item['Description']}',style: PoppinsWhite8,),
                Text('Time: ${item['timeSent'].toDate().toString()}',style: PoppinsWhite7,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}