// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';
//
// class NewPost extends StatefulWidget {
//   @override
//   _NewPostState createState() => _NewPostState();
// }
//
// class _NewPostState extends State<NewPost> {
//   final ImagePicker _picker = ImagePicker();
//   File? _imageFile;
//
//   Future<void> _selectImage() async {
//     final pickedSource = await Get.defaultDialog<ImageSource>(
//       title: "Select image from:",
//       content: Column(
//         children: [
//           ListTile(
//             leading: Icon(Icons.photo),
//             title: Text('Gallery'),
//             onTap: () => Get.back(result: ImageSource.gallery),
//           ),
//           ListTile(
//             leading: Icon(Icons.camera_alt),
//             title: Text('Camera'),
//             onTap: () => Get.back(result: ImageSource.camera),
//           ),
//           if (_imageFile != null)
//             ListTile(
//               leading: Icon(Icons.delete),
//               title: Text('Delete Image'),
//               onTap: () {
//                 setState(() {
//                   _imageFile = null;
//                 });
//                 Get.back();
//               },
//             ),
//         ],
//       ),
//     );
//
//     if (pickedSource != null) {
//       final pickedFile = await _picker.pickImage(source: pickedSource);
//       if (pickedFile != null) {
//         setState(() {
//           _imageFile = File(pickedFile.path);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Camera Access"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? Image.file(_imageFile!, height: 200, width: 200, fit: BoxFit.cover)
//                 : Icon(Icons.photo, size: 100),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _selectImage,
//               child: Text("Select Image"),
//             ),
//             if (_imageFile != null)
//               ElevatedButton(
//                 onPressed: () {
//
//                   Get.back(result: _imageFile);
//                 },
//                 child: Text("Save Image"),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// // // new_post.dart
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:get/get.dart';
// //
// // class NewPostPage extends StatefulWidget {
// //   @override
// //   _NewPostPageState createState() => _NewPostPageState();
// // }
// //
// // class _NewPostPageState extends State<NewPostPage> {
// //   File? _imageFile;
// //   final TextEditingController _descriptionController = TextEditingController();
// //
// //   Future<void> pickImage() async {
// //     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
// //     if (pickedFile != null) {
// //       setState(() {
// //         _imageFile = File(pickedFile.path);
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Create New Post"),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             _imageFile != null
// //                 ? Image.file(_imageFile!, height: 300, width: double.infinity, fit: BoxFit.cover)
// //                 : IconButton(
// //               onPressed: pickImage,
// //               icon: Icon(Icons.add_a_photo),
// //               iconSize: 50,
// //             ),
// //             TextField(
// //               controller: _descriptionController,
// //               decoration: InputDecoration(hintText: 'Enter a description'),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 if (_imageFile != null && _descriptionController.text.isNotEmpty) {
// //                   Get.back(result: {
// //                     'imageFile': _imageFile,
// //                     'description': _descriptionController.text,
// //                   });
// //                 }
// //               },
// //               child: Text("Post"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
