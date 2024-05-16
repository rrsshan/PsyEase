import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psyeasy/constants.dart';
import 'package:psyeasy/pages/addnote.dart';
import 'package:psyeasy/pages/addpdf.dart';
import 'package:psyeasy/pages/chat.dart';
import 'package:psyeasy/pages/home.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user =Provider.of<UserModel?>(context);

    if(user ==null){
      return SignUp();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:{
        '/':(context) => home(),
        '/chat': (context) => ChatScreen(),
        '/addnote' :(context) => addnote(),
        //'/addpdf' :(context) => addpdf(),
        // '/add': (context) => Add(),
        // '/tournament':(context) => CreateEventPage(),
        // '/profile': (context) => Profile(),
        // '/edit': (context) => Edit(),
        // '/replies': (context) => Replies()
      },
    );
  }
}

class UserModel {
  final String? id;
  final String? bannerImageUrl;
  final String? profileImageUrl;
  final String? name;
  final String? email;

  UserModel(
      {this.id,
      this.bannerImageUrl,
      this.profileImageUrl,
      this.name,
      this.email});
}


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();

  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Karp,
      appBar: AppBar(
        backgroundColor: Karp,
        elevation: 8,
        title: Text("Hello,",style: PoppinsWhite,),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Center(
          child: Form(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
      
                  hintText: 'abcd@gmail.com',
                  hintStyle: PoppinsWhite2,
                labelText: 'Email',
                labelStyle: PoppinsWhite2 ,
                border: OutlineInputBorder(
                  
                ),
              ),
                onChanged: (value) => setState(() {
                  email=value;
                }),
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                hintText: "pass-word",
                hintStyle: PoppinsWhite2,
                labelText: 'Password',
                labelStyle: PoppinsWhite2,
                border: OutlineInputBorder(),
              ),
                onChanged: (value) => setState(() {
                  password=value;
                }),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: Vella,
                width: 1.0,
              ),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Vella),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    // You can adjust other properties like border color, etc. here
                  ),
                ),),
                onPressed: () async=>{
              _authService.signUp(email, password),
            }, child: Text("Sign Up",style: TextStyle(color: Vella))),
              SizedBox(height: 10,width: 10,),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: Vella,
                width: 1.0,
              ),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Vella),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    // You can adjust other properties like border color, etc. here
                  ),
                ),),
                onPressed: () async=>{
              _authService.signIn(email, password)
            }, child: Text("Sign In",style: TextStyle(color: Vella))),
                ],
              )
            // ElevatedButton(onPressed: () async=>{
            //   _authService.signUp(email, password),
            //   //  Navigator.push(
            //   //   context,
            //   //   MaterialPageRoute(builder: (context) => homepage()),
            //   // )
            // }, child: Text("Sign Up")),
            // ElevatedButton(
            //   //style: ButtonStyle(),
            //   onPressed: () async=>{
            //   _authService.signIn(email, password)
            // }, child: Text("Sign In"))
           , SizedBox(height: 100,)
          ],)),
        ),
      ),
    );
  }
}

class AuthService{
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(id: user.uid) :  null;
  }

   Stream<UserModel?> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signUp(email, password) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({'name': email, 'email': email});
      _userFromFirebaseUser(user.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async{
    try{
      return await auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signIn(email, password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
          email: email, password: password)) as User;
      _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}