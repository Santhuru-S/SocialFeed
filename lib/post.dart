import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Videoplayer.dart';
import 'controller/postcontroller.dart';
import 'feedmodel/model.dart';


class PostCard extends StatelessWidget {
  final PostModel post;
  final PostController postController = Get.find();

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("User: ${post.userId}"), // Replace with user name
            subtitle: Text(post.timestamp.toString()),
          ),
          if (post.content.isNotEmpty) Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.content),
          ),
          if (post.imageUrl.isNotEmpty) Image.network(post.imageUrl),
          if (post.videoUrl.isNotEmpty)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayerWidget(videoUrl: post.videoUrl),
            ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  post.likes.contains("currentUserId") ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  postController.likePost(post.postId, "currentUserId");
                },
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  // Navigate to comment page
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Implement share functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
