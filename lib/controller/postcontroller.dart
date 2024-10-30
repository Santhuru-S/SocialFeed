import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../feedmodel/model.dart';


class PostController extends GetxController {
  var posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      posts.value = snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  Future<void> likePost(String postId, String userId) async {
    var postDoc = FirebaseFirestore.instance.collection('posts').doc(postId);
    var postSnapshot = await postDoc.get();

    if (postSnapshot.exists) {
      var currentLikes = List<String>.from(postSnapshot.data()?['likes'] ?? []);
      if (currentLikes.contains(userId)) {
        currentLikes.remove(userId);
      } else {
        currentLikes.add(userId);
      }
      await postDoc.update({'likes': currentLikes});
    }
  }
}
