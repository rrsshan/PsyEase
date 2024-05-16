import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psyeasy/constants.dart';
import 'package:psyeasy/notes/repo.dart';

class addnote extends StatefulWidget {
  const addnote({super.key});

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  String title = "";
  String Description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Vella,
        ),
        title: Text('Administrator',style: PoppinsWhite,),
        backgroundColor: Karp,
        // leading:
        //   IconButton(
        //     onPressed: (){

        //   }, 
        //   icon: Icon(Icons.,color: Manja,)),
        ),
        backgroundColor: Karp,
        body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 8),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 2,
                color: Vella,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.none,
                keyboardAppearance: Brightness.dark,
                onChanged: (value){
                  title = value;
                },
                style: PoppinsWhite2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),borderSide: BorderSide(
                      color: Vella,width: 5,
                    )
                  ),
                  //  labelText: 'Title',
                  // labelStyle: PoppinsWhite4,
                  hintText: 'Title',
                  hintStyle: PoppinsWhite2,
                ),
                //decoration: ,
              ),
              SizedBox(height: 12,),
              Flexible(
                child: TextField(
                  
                  decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),borderSide: BorderSide(
                      color: Vella,width: 5,
                    )
                  ),
                  //  labelText: 'Description',
                  // labelStyle: PoppinsWhite4,
                  hintText: 'Description',
                  hintStyle: PoppinsWhite8,
                ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 1000, // Allow multiple lines
                  textInputAction: TextInputAction.newline, 
                  onChanged: (value){
                  Description = value;
                },
                  style: PoppinsWhite8,
                  //maxLines: 100,
                  
                )),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () { 
                   _showConfirmationDialog(context);
                 },
                  child: Container(
                    height: 40,
                   // width: screenWidth,
                    decoration: BoxDecoration(
                      color: Pacha,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('Save',style: PoppinsWhite,))),
                ),
            ],
          )
          
          ),
        ),
    );
  }
   void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Vella,
          title: Text('Are you sure?',style: PoppinsBlack,),
          content: Text('Do you want to proceed?',style: PoppinsBlack,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Repo().addnote(title: title, description: Description);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}