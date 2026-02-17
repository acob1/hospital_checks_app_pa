import 'package:flutter/material.dart';
import '../../models/video_post.dart';
import 'animated_like_button.dart';

class VideoActionButtons extends StatelessWidget {
  final VideoPost post;
  final VoidCallback onLike;
  final VoidCallback onBookmark;

  const VideoActionButtons({
    super.key,
    required this.post,
    required this.onLike,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(post.doctorImage),
          backgroundColor: Colors.grey[800],
        ),
        const SizedBox(height: 20),
        AnimatedLikeButton(
          isLiked: post.isLiked,
          likeCount: post.likes,
          onTap: onLike,
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          Icons.comment_rounded,
          _formatCount(post.comments),
          () {},
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          Icons.share_rounded,
          _formatCount(post.shares),
          () {},
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: onBookmark,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                post.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: post.isBookmarked ? Colors.amber : Colors.white,
                size: 32,
              ),
              const SizedBox(height: 4),
              const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
