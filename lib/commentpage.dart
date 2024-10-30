import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialfeed/new%20feed/NewFeed.dart';

import 'new feed/image and video.dart';

class CommentPage extends StatefulWidget {
  final String postId; // ID of the post to which the comments belong

  CommentPage({required this.postId});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final List<String> _comments = []; // List to hold comments
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchComments(); // Fetch existing comments for the post
  }

  // Method to fetch comments from Firestore
  Future<void> _fetchComments() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('posts') // Your posts collection
        .doc(widget.postId)
        .collection('comments') // Subcollection for comments
        .get();

    setState(() {
      _comments.clear(); // Clear existing comments
      _comments.addAll(snapshot.docs.map((doc) => doc['comment'] as String)); // Add fetched comments
    });
  }

  // Method to add a new comment
  Future<void> _addComment(String comment) async {
    if (comment.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('posts') // Your posts collection
          .doc(widget.postId)
          .collection('comments') // Subcollection for comments
          .add({'comment': comment}); // Save the comment
      _commentController.clear(); // Clear the input field
      _fetchComments(); // Refresh the comments
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_comments[index])); // Display comments
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _addComment(_commentController.text.trim());
                    Get.to(SocialMediaFeedPage());// Add the comment
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
