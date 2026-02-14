import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/doctor_image.dart';
import '../../models/doctor.dart';
import 'doctor_detail_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'General', 'Cardiology', 'Dentist', 'Psychiatrist', 'Dermatologist'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Find Doctors',
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
      body: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildCategoryFilter(),
          const SizedBox(height: 16),
          Expanded(
            child: _buildDoctorsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search doctor...',
            hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.6)),
            prefixIcon: const Icon(Icons.search, color: AppColors.grey),
            suffixIcon: IconButton(
              icon: const Icon(Icons.tune, color: AppColors.grey),
              onPressed: () {},
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.lightGrey,
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.grey,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDoctorsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: sampleDoctors.length,
      itemBuilder: (context, index) {
        final doctor = sampleDoctors[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDetailScreen(doctor: doctor),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                DoctorImage(
                  imagePath: doctor.image,
                  size: 80,
                  borderRadius: 12,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialty,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor.hospital,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${doctor.rating}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${doctor.reviews} reviews)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.favorite_border,
                  color: AppColors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
