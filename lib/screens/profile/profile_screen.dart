import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatsCards(),
            const SizedBox(height: 24),
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 3),
                  ),
                  child: const Center(
                    child: Text('👤', style: TextStyle(fontSize: 50)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Amelia Renata',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'ameliarenata@gmail.com',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '102',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Heart rate',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '750',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Calories',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _buildMenuItem(Icons.person_outline, 'My Profile', () {}),
            _buildDivider(),
            _buildMenuItem(Icons.favorite_outline, 'Favorite Doctors', () {}),
            _buildDivider(),
            _buildMenuItem(Icons.receipt_long_outlined, 'Payment Method', () {}),
            _buildDivider(),
            _buildMenuItem(Icons.schedule_outlined, 'My Appointments', () {}),
            _buildDivider(),
            _buildMenuItem(Icons.article_outlined, 'FAQ', () {}),
            _buildDivider(),
            _buildMenuItem(Icons.settings_outlined, 'Settings', () {}),
            _buildDivider(),
            _buildMenuItem(Icons.logout, 'Logout', () {}, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? AppColors.red : AppColors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? AppColors.red : AppColors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isLogout ? AppColors.red : AppColors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.grey.withValues(alpha: 0.2),
    );
  }
}
