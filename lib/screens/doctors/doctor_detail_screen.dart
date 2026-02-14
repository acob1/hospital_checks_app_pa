import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/doctor_image.dart';
import '../../models/doctor.dart';
import '../appointment/appointment_screen.dart';
import '../messages/chat_detail_screen.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
        ],
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorInfo(),
            const SizedBox(height: 20),
            _buildStats(),
            const SizedBox(height: 20),
            _buildBookButton(context),
            const SizedBox(height: 24),
            _buildServices(context),
            const SizedBox(height: 24),
            _buildAbout(),
            const SizedBox(height: 24),
            _buildReviews(),
            const SizedBox(height: 24),
            _buildLocation(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      children: [
        DoctorImage(imagePath: doctor.image, size: 150, borderRadius: 16),
        const SizedBox(height: 16),
        Text(
          doctor.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.medical_services_outlined,
              size: 16,
              color: AppColors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              doctor.specialty,
              style: const TextStyle(fontSize: 14, color: AppColors.grey),
            ),
            const SizedBox(width: 16),
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: AppColors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              doctor.hospital.split(',')[0],
              style: const TextStyle(fontSize: 14, color: AppColors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(
            Icons.people_outline,
            '${doctor.patients}+',
            'Patients',
          ),
          _buildStatItem(
            Icons.work_outline,
            '${doctor.experience}',
            'Experience',
          ),
          _buildStatItem(Icons.star, '${doctor.rating}', 'Rating'),
          _buildStatItem(
            Icons.rate_review_outlined,
            '${doctor.reviews}',
            'Reviews',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.secondary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _buildBookButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentScreen(doctor: doctor),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Book Now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildServiceItem(
                Icons.message_outlined,
                'Messaging',
                onTap: () => _openChat(context),
              ),
              _buildServiceItem(Icons.call_outlined, 'Audio Call'),
              _buildServiceItem(Icons.videocam_outlined, 'Video Call'),
              _buildServiceItem(Icons.medical_services_outlined, 'Medicine'),
            ],
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
          doctorName: doctor.name,
          doctorImage: doctor.image,
        ),
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAbout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            doctor.about.isNotEmpty
                ? doctor.about
                : 'The Doctor Profile & Details in UI/UX provides users with a comprehensive overview of their healthcare provider. Detailed information can be viewed on the doctor\'s qualifications, specialty, and experience. The Profile includes language spoken and the list of services they provide. This helps users to make good decision about which doctor best suits their needs.\n\nAdditionally, the profile includes patient reviews and ratings, which can provide insights into the doctor\'s bedside manner, the accessibility of their office and the overall patient experience. Users may also find information directly from their profile, making the scheduling process seamless and efficient.',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.grey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 48, color: AppColors.primary),
                  SizedBox(height: 8),
                  Text(
                    'Map View',
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildReviewItem('Imran Syahir', 5.0, '2 day ago'),
          const SizedBox(height: 12),
          _buildReviewItem('William Andrew', 5.0, '3 Day ago'),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, double rating, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('👤', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (index) =>
                  const Icon(Icons.star, color: AppColors.accent, size: 18),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy type ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: TextStyle(fontSize: 12, color: AppColors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentScreen(doctor: doctor),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _openChat(context),
              child: _buildActionButton(
                Icons.chat_bubble_outline,
                const Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(width: 8),
            _buildActionButton(
              Icons.videocam_outlined,
              const Color(0xFF4CAF50),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
