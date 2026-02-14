import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class VideoCallScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImage;

  const VideoCallScreen({
    super.key,
    required this.doctorName,
    required this.doctorImage,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMicOn = true;
  bool _isCameraOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video (doctor's image - full screen)
          Positioned.fill(
            child: Image.asset(
              widget.doctorImage,
              fit: BoxFit.cover,
            ),
          ),

          // Local video (user's PiP - top right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: Container(
              width: 100,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/humberto-chavez-FVh_yqLR9eA-unsplash.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Bottom control bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 32,
                right: 32,
                top: 24,
                bottom: MediaQuery.of(context).padding.bottom + 24,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: _isMicOn ? Icons.mic : Icons.mic_off,
                    color: const Color(0xFF3B5998),
                    onTap: () => setState(() => _isMicOn = !_isMicOn),
                  ),
                  _buildControlButton(
                    icon: _isCameraOn ? Icons.videocam : Icons.videocam_off,
                    color: const Color(0xFF3B5998),
                    onTap: () => setState(() => _isCameraOn = !_isCameraOn),
                  ),
                  _buildControlButton(
                    icon: Icons.cameraswitch,
                    color: const Color(0xFF3B5998),
                    onTap: () {},
                  ),
                  _buildControlButton(
                    icon: Icons.call_end,
                    color: AppColors.red,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
