import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'chat_detail_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          final doctors = [
            {
              'name': 'Dr. Imran Syahir',
              'specialty': 'General Doctor',
              'message': 'How is your diabetes treatment going, are you taking the med...',
              'time': '10:24',
              'image': 'assets/images/artur-tumasjan-qLzWvcQq-V8-unsplash.jpg',
            },
            {
              'name': 'Dr. William Andrew',
              'specialty': 'Cardiologist',
              'message': 'Hello, How can i help you?',
              'time': '09:45',
              'image': 'assets/images/sander-sammy-38Un6Oi5beE-unsplash.jpg',
            },
            {
              'name': 'Dr. Zenith Smith',
              'specialty': 'Dentist',
              'message': 'I will examine your teeth immediately connect.',
              'time': 'Yesterday',
              'image': 'assets/images/bruno-rodrigues-279xIHymPYY-unsplash.jpg',
            },
            {
              'name': 'Dr. Sandyka Lee',
              'specialty': 'Pediatric',
              'message': 'Your General surgeon of Starlight Community Juveni...',
              'time': '12/08/24',
              'image': 'assets/images/mohamad-azaam-1O8CJy1A7Wo-unsplash.jpg',
            },
          ];

          final doctor = doctors[index];
          return _buildMessageItem(
            context,
            doctor['name']!,
            doctor['specialty']!,
            doctor['message']!,
            doctor['time']!,
            doctor['image']!,
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(
    BuildContext context,
    String name,
    String specialty,
    String message,
    String time,
    String image,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              doctorName: name,
              doctorImage: image,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grey.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
