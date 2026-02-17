import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../models/video_post.dart';
import 'animated_like_button.dart';
import 'video_action_buttons.dart';
import 'video_overlay.dart';

class VideoPlayerItem extends StatefulWidget {
  final VideoPost post;
  final bool isActive;
  final VoidCallback onLike;
  final VoidCallback onBookmark;

  const VideoPlayerItem({
    super.key,
    required this.post,
    required this.isActive,
    required this.onLike,
    required this.onBookmark,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  final List<_HeartAnimationData> _hearts = [];
  int _heartIdCounter = 0;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (widget.post.isLocal) {
      _videoController = VideoPlayerController.file(File(widget.post.videoUrl));
    } else {
      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(widget.post.videoUrl));
    }

    await _videoController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: widget.isActive,
      looping: true,
      showControls: false,
      aspectRatio: _videoController.value.aspectRatio,
    );

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void didUpdateWidget(VideoPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _videoController.play();
      } else {
        _videoController.pause();
      }
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _handleDoubleTap(TapDownDetails details) {
    if (!widget.post.isLiked) {
      widget.onLike();
    }
    final id = _heartIdCounter++;
    setState(() {
      _hearts.add(_HeartAnimationData(
        id: id,
        position: details.localPosition,
      ));
    });
  }

  void _removeHeart(int id) {
    setState(() {
      _hearts.removeWhere((h) => h.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video player
          if (_isInitialized && _chewieController != null)
            Center(
              child: AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: Chewie(controller: _chewieController!),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // Tap gesture layer
          GestureDetector(
            onDoubleTapDown: _handleDoubleTap,
            onDoubleTap: () {},
            onTap: () {
              if (_videoController.value.isPlaying) {
                _videoController.pause();
              } else {
                _videoController.play();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),

          // Bottom overlay info
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: VideoOverlay(post: widget.post),
          ),

          // Right side action buttons
          Positioned(
            right: 12,
            bottom: 100,
            child: VideoActionButtons(
              post: widget.post,
              onLike: widget.onLike,
              onBookmark: widget.onBookmark,
            ),
          ),

          // Double-tap heart animations
          ..._hearts.map((heart) => DoubleTapHeartOverlay(
                key: ValueKey(heart.id),
                position: heart.position,
                onComplete: () => _removeHeart(heart.id),
              )),

          // Progress bar at bottom
          if (_isInitialized)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: VideoProgressIndicator(
                _videoController,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Colors.white,
                  bufferedColor: Colors.white38,
                  backgroundColor: Colors.white12,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }
}

class _HeartAnimationData {
  final int id;
  final Offset position;

  _HeartAnimationData({required this.id, required this.position});
}
