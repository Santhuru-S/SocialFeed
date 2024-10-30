// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:share/share.dart';
// import 'package:socialfeed/new%20feed/Newcomment%20page.dart';
//
// import '../commentpage.dart';
// import '../controller/newdemo.dart';
// import 'image and video.dart';
// import 'new post.dart';
// //
//
// class Comment {
//   final String userId;
//   final String text;
//   final DateTime timestamp;
//
//   Comment({
//     required this.userId,
//     required this.text,
//     required this.timestamp,
//   });
// }
//
// class Post {
//   final List<String> imageUrls;
//   final String description;
//   int likes;
//   int comments;
//   List<Comment> commentList;
//
//   Post({
//     required this.imageUrls,
//     required this.description,
//     required this.likes,
//     required this.comments,
//     this.commentList = const [], required mediaFiles,
//   });
// }
//
// class SocialMediaFeed extends StatefulWidget {
//   final List<MediaFile> mediaFiles;
//   SocialMediaFeed({required this.mediaFiles});
//
//   @override
//   _SocialMediaFeedState createState() => _SocialMediaFeedState();
// }
//
// class MediaFile {
// }
//
// class _SocialMediaFeedState extends State<SocialMediaFeed> {
//   File? _image;
//
//   final List<Post> posts = [
//     Post(
//       imageUrls: [
//         "https://www.investopedia.com/thmb/tFHjCFL9uLlgj5_yQ6xt6WzH7iQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/social-media-final-8f48359ac9e7486eaf40932f4a9e2597.png",
//         "https://www.simplilearn.com/ice9/free_resources_article_thumb/Importance_of_Social_Media_in_Todays_World.jpg",
//         "https://www.simplilearn.com.cach3.com/ice9/free_resources_article_thumb/real-impact-social-media.jpg",
//       ],
//       description: "Amazing day with nature!",
//       likes: 20,
//       comments: 5, mediaFiles: null,
//     ),
//     // Add more posts if needed
//   ];
//
//   List<bool> likedStatus = [];
//
//   get mediaFiles => null; // To track like status for each post
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the likedStatus list
//     likedStatus = List.generate(posts.length, (index) => false);
//   }
//
//   void toggleLike(int index) {
//     setState(() {
//       likedStatus[index] = !likedStatus[index]; // Toggle the like status
//       if (likedStatus[index]) {
//         posts[index].likes++; // Increment likes if liked
//       } else {
//         posts[index].likes--; // Decrement likes if unliked
//       }
//     });
//   }
//   void addPost(Post newPost) {
//     setState(() {
//       posts.insert(0, newPost); // Add the new post at the beginning of the list
//       likedStatus.insert(0, false); // Set initial like status to false
//     });
//   }
//
//   void deletePost(int index) {
//     setState(() {
//       posts.removeAt(index);
//       likedStatus.removeAt(index);
//     });
//   }
//
//   // void sharePost(Post post) {
//   //   // Create a message to share
//   //   final message = 'Check out this post: "${post.description}"\n${post.imageUrls}';
//   //   Share.share(message);
//   // }
//   void sharePost(Post post) {
//     final message = 'Check out this post: "${post.description}"\n${post.imageUrls}';
//     Share.share(message);
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Social Media Feed"),
//       ),
//       body: ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 300,
//                   child: CarouselSlider(
//                     options: CarouselOptions(
//                       height: 300,
//                       viewportFraction: 1.0,
//                       enableInfiniteScroll: false,
//                       enlargeCenterPage: false,
//                     ),
//                     items: posts[index].imageUrls.map((imageUrl) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           if (Uri.tryParse(imageUrl)?.hasScheme == true){
//                             return Container(
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(image: NetworkImage(imageUrl),
//                                 fit: BoxFit.cover)
//                               ),
//                             );
//                           }else {
//                             return Container(
//                               width: MediaQuery.of(context).size.width,
//                               child: Image.file(File(imageUrl),fit: BoxFit.cover,),
//                             );
//                           }
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(posts[index].description),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () => toggleLike(index), // Call the toggle function
//                       icon: Icon(
//                         likedStatus[index] ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
//                         color: likedStatus[index] ? Colors.red : Colors.grey,
//                       ),
//                     ),
//                     // IconButton(
//                     //   onPressed: () {
//                     //     // Navigate to the CommentPage and pass the relevant post ID or data
//                     //     Get.to(() => CommentPage(postId: posts[index].commentList.toString()));
//                     //   },
//                     //   icon: Icon(Icons.comment),
//                     // ),
//                     IconButton(
//                       onPressed: () {
//                         // Navigate to the CommentPage and pass the relevant post ID or data
//                         Get.to(() => CommentScreen(postId: posts[index].commentList.toString()));
//                       },
//                       icon: Icon(Icons.comment),
//                     ),
//                     IconButton(
//                       onPressed: () => sharePost(posts[index]),
//                       icon: Icon(Icons.share),
//                     ),
//                     IconButton(
//                       onPressed: () => deletePost(index),
//                       icon: Icon(Icons.delete, color: Colors.red),
//                     ),
//                   ],
//                 ),
//                 Text('${posts[index].likes} Likes'), // Display the like count
//                 Divider(),
//                 _image != null
//                 ? Image.file(_image!,height: 350,
//                   width: MediaQuery.of(context).size.width,
//                 fit: BoxFit.cover,)
//                     : Icon(Icons.photo),
//                 // ListView.builder(
//                 //   itemCount: mediaFiles.length,
//                 //   itemBuilder: (context, index) {
//                 //     final mediaFile = mediaFiles[index];
//                 //     return Padding(
//                 //       padding: const EdgeInsets.symmetric(vertical: 5.0),
//                 //       child: mediaFile.isVideo
//                 //           ? Container(
//                 //         height: 200,
//                 //         width: double.infinity,
//                 //         color: Colors.black,
//                 //         child: Center(
//                 //           child: Icon(Icons.videocam,
//                 //               color: Colors.white, size: 50),
//                 //         ),
//                 //       )
//                 //           : Image.file(
//                 //         File(mediaFile.path),
//                 //         height: 350,
//                 //         width: MediaQuery.of(context).size.width,
//                 //         fit: BoxFit.cover,
//                 //       ),
//                 //     );
//                 //   },
//                 // ),
//               ],
//             ),
//           );
//         },
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () async {
//       //     // Navigate to NewPostPage to create a new post
//       //    // final newPost = await Get.to(() => NewPostsecond());
//       //
//       //     if (newPost != null) {
//       //       // Add the new post to the feed
//       //       addPost(newPost);
//       //       // You can also call sharePost directly if needed
//       //       // sharePost(newPost);
//       //     }
//       //   },
//       //   child: Text("post"),
//       // ),
//
//     );
//   }
// }
//
