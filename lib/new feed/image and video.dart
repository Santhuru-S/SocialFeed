import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

import 'Newcomment page.dart';

class SocialMediaFeedPage extends StatefulWidget {
  @override
  _SocialMediaFeedPageState createState() => _SocialMediaFeedPageState();
}

class _SocialMediaFeedPageState extends State<SocialMediaFeedPage> {
  List<Post> posts = [];
  List<bool> likedStatus = [];

  final ImagePicker _picker = ImagePicker();
  TextEditingController descriptionController = TextEditingController();

  // Method to pick image or video
  Future<void> pickMedia(ImageSource source, bool isVideo) async {
    final XFile? media = isVideo
        ? await _picker.pickVideo(source: source)
        : await _picker.pickImage(source: source);

    if (media != null) {
      setState(() {
        final newPost = Post(
          description: descriptionController.text,
          mediaFiles: [MediaFile(path: media.path, isVideo: isVideo)],
          likes: 0,
          comments: 0,
        );
        posts.insert(0, newPost);
        likedStatus.insert(0, false);
      });
      descriptionController.clear();
    }
  }
  void toggleLike(int index) {
    setState(() {
      likedStatus[index] = !likedStatus[index]; // Toggle the like status
      if (likedStatus[index]) {
        posts[index].likes++; // Increment likes if liked
      } else {
        posts[index].likes--; // Decrement likes if unliked
      }
    });
  }

  // Share Post
  void sharePost(Post post) {
    final message = 'Check out this post: "${post.description}"\n${post.imageUrls}';
    Share.share(message);
  }

  // Show media picking options
  // Show media picking options for both image and video
  void _showMediaSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Select Image from Gallery'),
                onTap: () {
                  pickMedia(ImageSource.gallery, false); // For image
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Select Video from Gallery'),
                onTap: () {
                  pickMedia(ImageSource.gallery, true); // For video
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take Photo'),
                onTap: () {
                  pickMedia(ImageSource.camera, false); // For image
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Record Video'),
                onTap: () {
                  pickMedia(ImageSource.camera, true); // For video
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  // Widget to display videos using VideoPlayer
  Widget _buildMediaWidget(MediaFile mediaFile) {
    if (mediaFile.isVideo) {
      return VideoPlayerWidget(filePath: mediaFile.path);
    } else {
      return Image.file(
        File(mediaFile.path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
      );
    }
  }
  void deletePost(int index) {
    setState(() {
      posts.removeAt(index);
      likedStatus.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Social Media Feed")),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (posts[index].mediaFiles.isNotEmpty)
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                  ),
                  items: posts[index].mediaFiles.map((mediaFile) {
                    return _buildMediaWidget(mediaFile);
                  }).toList(),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(posts[index].description),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => toggleLike(index),
                    icon: Icon(
                      likedStatus[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: likedStatus[index] ? Colors.red : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => CommentScreen(postId: posts[index].commentList.toString()));
                    },
                    icon: Icon(Icons.comment),
                  ),
                  IconButton(
                    onPressed: () => sharePost(posts[index]),
                    icon: Icon(Icons.share),
                  ),
                  IconButton(
                    onPressed: () => deletePost(index),
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
              Text('${posts[index].likes} Likes'),
              Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMediaSourceOptions();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

extension on Post {
  get imageUrls => null;
}

class MediaFile {
  final String path;
  final bool isVideo;

  MediaFile({required this.path, required this.isVideo});
}

class Post {
  final String description;
  final List<MediaFile> mediaFiles;
  int likes;
  int comments;

  Post({
    required this.description,
    required this.mediaFiles,
    required this.likes,
    required this.comments,
  });

  get commentList => null;
}

// VideoPlayer Widget to handle video files
class VideoPlayerWidget extends StatefulWidget {
  final String filePath;

  VideoPlayerWidget({required this.filePath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
}
