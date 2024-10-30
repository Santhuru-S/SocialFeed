import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:socialfeed/new%20feed/NewFeed.dart';

import 'Signin page.dart';
import 'controller/newdemo.dart';
import 'new feed/image and video.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 70, left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please Enter Email';
                  }return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please Enter Password';
                  }return null;
                },
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.key),
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) { // Validate form
                    try {
                      await authProvider.signIn(email.text, password.text);
                      Get.to(SocialMediaFeedPage());
                    } catch (e) {
                      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
                    }
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text('or',style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Get.to(Createaccount());
            },child: Text('Create Account',
              style: TextStyle(fontSize: 15,color: Colors.blue),))
          ],
        ),
      ),
    );
  }
}


class AuthProvider with ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  User? get currentUser =>_auth.currentUser;

  bool get isSignedIn => currentUser != null;
  Future<void> signIn(String email, String password) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      // Sign in the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user info
      User? user = userCredential.user;

      // Check if user is not null
      if (user != null) {
        // Save user data to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'lastLogin': DateTime.now(),
        }, SetOptions(merge: true)); // Use merge to avoid overwriting existing data
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }


  Future<void> signOut()async{
    await _auth.signOut();
    notifyListeners();
  }
}
