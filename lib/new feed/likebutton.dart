// import 'package:flutter/material.dart';
// import 'package:like_button/like_button.dart';
//
// class LikeButton extends StatefulWidget {
//   @override
//   _LikeButtonState createState() => _LikeButtonState();
// }
//
// class _LikeButtonState extends State<LikeButton> {
//   int likeCount = 20;
//
//   Future<bool> onLikeButtonTapped(bool isLiked) async {
//     // Optionally, perform an action like API call, or database update here
//     setState(() {
//       likeCount += isLiked ? -1 : 1;
//     });
//     return !isLiked;
//   }
//
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Like Button Example'),
//         ),
//         body: Center(
//           child: LikeButton(
//             size: 40,
//             isLiked: false, // Initial state of the like button
//             likeCount: likeCount,
//             onTap: onLikeButtonTapped,
//             likeBuilder: (bool isLiked) {
//               return Icon(
//                 Icons.favorite,
//                 color: isLiked ? Colors.red : Colors.grey,
//                 size: 40,
//               );
//             },
//             countBuilder: (int? count, bool isLiked, String text) {
//               var color = isLiked ? Colors.red : Colors.grey;
//               return Text(
//                 text,
//                 style: TextStyle(color: color),
//               );
//             },
//           ),
//         ),
//       );
//   }
// }
