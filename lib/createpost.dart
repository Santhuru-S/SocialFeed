import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController contentController = TextEditingController();
  String imageUrl = '';
  final ImagePicker picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      var storageRef = FirebaseStorage.instance.ref().child('posts/${DateTime.now()}.jpg');
      await storageRef.putFile(imageFile);
      String url = await storageRef.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    }
  }

  Future<void> createPost() async {
    final User? user = _auth.currentUser; // Get the current user
    if (user == null) {
      // Handle the case when user is not authenticated
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not logged in')));
      return;
    }

    await FirebaseFirestore.instance.collection('posts').add({
      'userId': user.uid, // Use the current user's ID
      'content': contentController.text,
      'imageUrl': imageUrl,
      'likes': [],
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Post"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: createPost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: contentController,
              decoration: InputDecoration(hintText: 'Write something...'),
            ),
            SizedBox(height: 10),
            if (imageUrl.isNotEmpty) Image.network(imageUrl),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.photo),
              label: Text("Pick Image"),
            ),
          ],
        ),
      ),
    );
  }
}




