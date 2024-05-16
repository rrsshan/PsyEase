import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psyeasy/constants.dart';


class students extends StatefulWidget {
  const students({super.key});

  @override
  State<students> createState() => _studentsState();
}

class _studentsState extends State<students> {
  final CollectionReference player =
      FirebaseFirestore.instance.collection('Students');

  String name = '';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // Retrieving screen width and height
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Vella),
        automaticallyImplyLeading: true,        
        centerTitle: true,
        backgroundColor: Karp,
        title: Text("Student List",style: PoppinsWhite,),
      ),
      backgroundColor: Vella,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            height: screenHeight-150,
            width: screenWidth-10,
            child: StreamBuilder(
            stream: player.orderBy('Name').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
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
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Karp,
                                ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Vella,),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      playerSnap['Name'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Semster: '+playerSnap['Semester'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
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
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 4,
                )
              ),
                prefixIcon: Icon(Icons.search), hintText: 'Search Here..'),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          ],
        ),
      )
    );
  }
}