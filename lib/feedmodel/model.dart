import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String postId;
  String userId;
  String content;
  String imageUrl;
  String videoUrl;
  List<String> likes;
  DateTime timestamp;

  PostModel({
    required this.postId,
    required this.userId,
    required this.content,
    this.imageUrl = '',
    this.videoUrl = '',
    this.likes = const [],
    required this.timestamp,
  });

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return PostModel(
      postId: doc.id,
      userId: data['userId'],
      content: data['content'],
      imageUrl: data['imageUrl'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      likes: List<String>.from(data['likes'] ?? []),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
