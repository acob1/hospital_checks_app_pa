import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'home/home_screen.dart';
import 'videos/video_feed_screen.dart';
import 'messages/messages_screen.dart';
import 'schedule/schedule_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    VideoFeedScreen(),
    ScheduleScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 0),
                _buildNavItem(Icons.play_circle_outline, Icons.play_circle, '', 1),
                _buildNavItem(Icons.calendar_today_outlined, Icons.calendar_today, '', 2),
                _buildNavItem(Icons.chat_bubble_outline, Icons.chat_bubble, '', 3),
                _buildNavItem(Icons.person_outline, Icons.person, '', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: label.isEmpty ? 16 : 12,
          vertical: 8
        ),
        decoration: BoxDecoration(
          color: isSelected && index == 0 ? AppColors.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected && index == 0 ? Colors.white : (isSelected ? AppColors.secondary : AppColors.grey),
              size: 24,
            ),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : AppColors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
