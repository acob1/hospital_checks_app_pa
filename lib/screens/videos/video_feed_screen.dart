import 'package:flutter/material.dart';
import '../../models/video_post.dart';
import 'video_player_item.dart';
import 'video_upload_screen.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({super.key});

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  int _currentPage = 0;
  late List<VideoPost> _videos;

  @override
  void initState() {
    super.initState();
    _videos = List.from(sampleVideoPosts);
  }

  void _toggleLike(int index) {
    setState(() {
      _videos[index].isLiked = !_videos[index].isLiked;
      _videos[index].likes += _videos[index].isLiked ? 1 : -1;
    });
  }

  void _toggleBookmark(int index) {
    setState(() {
      _videos[index].isBookmarked = !_videos[index].isBookmarked;
    });
  }

  Future<void> _navigateToUpload() async {
    final result = await Navigator.push<VideoPost>(
      context,
      MaterialPageRoute(builder: (_) => const VideoUploadScreen()),
    );
    if (result != null) {
      setState(() {
        _videos.insert(0, result);
        _currentPage = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Health Tips',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
            onPressed: _navigateToUpload,
          ),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _videos.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return VideoPlayerItem(
            post: _videos[index],
            isActive: index == _currentPage,
            onLike: () => _toggleLike(index),
            onBookmark: () => _toggleBookmark(index),
          );
        },
      ),
    );
  }
}
