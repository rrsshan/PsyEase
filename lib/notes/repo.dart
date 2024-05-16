import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:psyeasy/model/note.dart';

class Repo {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void addnote({
    required title,required description,
  }) async {

     final collection = firestore.collection('notes').doc();
     NoteModel notemodel = NoteModel(title: title, Description: description, UserId: auth.currentUser!.uid, NoteId: collection.id, timeSent: DateTime.now());
  await collection.set(notemodel.toMap());
  }
}