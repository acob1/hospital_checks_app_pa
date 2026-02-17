import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/colors.dart';
import '../../models/video_post.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({super.key});

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedVideo;
  bool _isUploading = false;

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _selectedVideo = File(video.path);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_selectedVideo == null || _titleController.text.isEmpty) return;

    setState(() {
      _isUploading = true;
    });

    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 2));

    final newPost = VideoPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      videoUrl: _selectedVideo!.path,
      doctorName: 'You',
      doctorSpecialty: 'Health Tip',
      doctorImage: 'https://i.pravatar.cc/150?img=12',
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : _titleController.text,
      isLocal: true,
    );

    if (mounted) {
      Navigator.pop(context, newPost);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Upload Video',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video picker area
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.3),
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                child: _selectedVideo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              color: Colors.black87,
                              child: const Center(
                                child: Icon(
                                  Icons.play_circle_filled,
                                  color: Colors.white,
                                  size: 64,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedVideo = null),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library_outlined,
                            size: 48,
                            color: AppColors.grey.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Tap to select a video',
                            style: TextStyle(
                              color: AppColors.grey.withValues(alpha: 0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Choose from your gallery',
                            style: TextStyle(
                              color: AppColors.grey.withValues(alpha: 0.5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Title field
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Give your health tip a title',
                hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Description field
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Describe your video content...',
                hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 32),

            // Upload button
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _selectedVideo != null && !_isUploading
                    ? _uploadVideo
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.grey.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: _isUploading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        'Upload Video',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
