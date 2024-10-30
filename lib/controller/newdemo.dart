// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../new feed/NewFeed.dart';
//
// import 'package:image_picker/image_picker.dart'; // Import the image picker package
//
// class NewPostsecond extends StatefulWidget {
//   @override
//   _NewPostsecondState createState() => _NewPostsecondState();
// }
//
// class _NewPostsecondState extends State<NewPostsecond> {
//   TextEditingController descriptionController = TextEditingController();
//   List<String> imageUrls = [];
//   final ImagePicker _picker = ImagePicker(); // Create an instance of ImagePicker
//
//   // This method handles the image selection and upload process
//   Future<void> pickAndUploadImage(ImageSource source) async {
//     final XFile? image = await _picker.pickImage(source: source);
//
//     if (image != null) {
//       // Here, you would usually upload the image to your server or storage and get the URL.
//       // For this example, we're just adding the local path to simulate an upload.
//       setState(() {
//         imageUrls.add(image.path); // Adding the local path (You can use uploaded URL)
//       });
//     }
//   }
//
//   void submitPost() {
//     // Check if description and images are provided
//     if (descriptionController.text.isNotEmpty && imageUrls.isNotEmpty) {
//       final newPost = Post(
//         description: descriptionController.text,
//         imageUrls: imageUrls,
//         likes: 0,
//         comments: 0, mediaFiles: null,
//       );
//
//       // Return the newly created post
//       Get.back(result: newPost);
//     }
//   }
//
//   // void submitPost() {
//   //   if (descriptionController.text.isNotEmpty && mediaFiles.isNotEmpty) {
//   //     final newPost = Post(
//   //       description: descriptionController.text,
//   //       mediaFiles: mediaFiles,
//   //       likes: 0,
//   //       comments: 0, imageUrls: [],
//   //     );
//   //
//   //     // Navigate to the second page and pass the media files
//   //     Get.to(() => SecondPage(mediaFiles: mediaFiles));
//   //   }
//   // }
//
//   void _showImageSourceOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () {
//                   pickAndUploadImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text('Camera'),
//                 onTap: () {
//                   pickAndUploadImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create New Post')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: descriptionController,
//               decoration: InputDecoration(hintText: 'Enter description'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _showImageSourceOptions,
//               child: Text('Upload Image'),
//             ),
//
//             // Expanded(
//             //   child: ListView.builder(
//             //     itemCount: imageUrls.length,
//             //     itemBuilder: (context, index) {
//             //       // Check if the image URL is a network URL or a local file path
//             //       if (Uri.parse(imageUrls[index]).isAbsolute) {
//             //         // Display network image if it's a full URL
//             //         return Image.file(File(imageUrls[index]));
//             //       } else {
//             //         // Display local file image if it's a file path
//             //         return Image.file(File(imageUrls[index]));
//             //       }
//             //     },
//             //   ),
//             // ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: imageUrls.length,
//                 itemBuilder: (context, index) {
//                   // Always use Image.file for local file paths
//                   return Image.file(
//                     File(imageUrls[index]),
//                     fit: BoxFit.cover,
//                   );
//                 },
//               ),
//             ),
//
//             ElevatedButton(
//               onPressed: submitPost,
//               child: Text('Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
