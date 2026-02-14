import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Schedule',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabs(),
          const SizedBox(height: 20),
          Expanded(
            child: _buildAppointmentsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 0 ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Upcoming',
                    style: TextStyle(
                      color: _selectedTab == 0 ? Colors.white : AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 1 ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: _selectedTab == 1 ? Colors.white : AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 2),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 2 ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Cancelled',
                    style: TextStyle(
                      color: _selectedTab == 2 ? Colors.white : AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, String>> _doctors = const [
    {
      'name': 'Dr. Marcus Horizon',
      'specialty': 'Cardiologist',
      'image': 'assets/images/usman-yousaf-PVjfLss3b-c-unsplash.jpg',
    },
    {
      'name': 'Dr. Maria Elena',
      'specialty': 'Dentist',
      'image': 'assets/images/linkedin-sales-solutions-pAtA8xe_iVM-unsplash.jpg',
    },
    {
      'name': 'Dr. Stevi Jessi',
      'specialty': 'Neurologist',
      'image': 'assets/images/humberto-chavez-FVh_yqLR9eA-unsplash.jpg',
    },
  ];

  Widget _buildAppointmentsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return _buildAppointmentCard(
          doctor['name']!,
          doctor['specialty']!,
          doctor['image']!,
          'Monday, Aug ${26 + index}, 2024',
          '10:00 AM',
          _selectedTab,
        );
      },
    );
  }

  Widget _buildAppointmentCard(String name, String specialty, String imagePath, String date, String time, int status) {
    Color statusColor;
    String statusText;

    switch (status) {
      case 0:
        statusColor = AppColors.accent;
        statusText = 'Upcoming';
        break;
      case 1:
        statusColor = AppColors.primary;
        statusText = 'Completed';
        break;
      default:
        statusColor = AppColors.red;
        statusText = 'Cancelled';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: AppColors.grey),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.access_time, size: 16, color: AppColors.grey),
                const SizedBox(width: 8),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              const Spacer(),
              if (status == 0) ...[
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Reschedule',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
