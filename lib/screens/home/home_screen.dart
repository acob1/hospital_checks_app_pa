import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/doctor.dart';
import '../../widgets/doctor_image.dart';
import '../doctors/doctor_detail_screen.dart';
import '../doctors/doctor_list_screen.dart';
import '../messages/messages_screen.dart';
import '../profile/profile_screen.dart';
import '../schedule/schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedSpecialty = 'General';
  int _selectedBottomNavIndex = 0;
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildCategories(context),
            const SizedBox(height: 24),
            _buildPromoBanner(),
            const SizedBox(height: 24),
            _buildDoctorsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedBottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Already on Home
          return;
        }

        setState(() {
          _selectedBottomNavIndex = index;
        });

        // Navigate to different screens
        if (index == 1) {
          // Calendar/Schedule
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScheduleScreen()),
          ).then((_) {
            setState(() {
              _selectedBottomNavIndex = 0;
            });
          });
        } else if (index == 2) {
          // Messages
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MessagesScreen()),
          ).then((_) {
            setState(() {
              _selectedBottomNavIndex = 0;
            });
          });
        } else if (index == 3) {
          // Profile
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          ).then((_) {
            setState(() {
              _selectedBottomNavIndex = 0;
            });
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.grey,
              size: 22,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/linkedin-sales-solutions-pAtA8xe_iVM-unsplash.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, John Doe',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'How are you feeling today?',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorListScreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for Doctor...',
                hintStyle: TextStyle(
                  color: AppColors.grey.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categoryList = [
      {
        'name': 'General',
        'icon': Icons.people_outline,
        'color': AppColors.secondary,
      },
      {
        'name': 'Dentist',
        'icon': Icons.medical_services,
        'color': AppColors.secondary,
      },
      {
        'name': 'Ophthalmology',
        'icon': Icons.remove_red_eye_outlined,
        'color': AppColors.secondary,
      },
      {
        'name': 'Nutrition',
        'icon': Icons.favorite_outline,
        'color': AppColors.secondary,
      },
      {
        'name': 'Neurology',
        'icon': Icons.psychology_outlined,
        'color': AppColors.secondary,
      },
      {'name': 'Pediatric', 'icon': Icons.people, 'color': AppColors.secondary},
      {
        'name': 'Radiology',
        'icon': Icons.medical_information_outlined,
        'color': AppColors.secondary,
      },
      {'name': 'More', 'icon': Icons.more_horiz, 'color': AppColors.secondary},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final category = categoryList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoctorListScreen(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: (category['color'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: category['color'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category['name'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    final banners = [
      _BannerData(
        title1: 'Medical Care',
        title2: 'in the U.S.',
        description:
            'Take care of your health and happiness with us. We are here every step of the way.',
        badge: 'Think Healthcare Solutions.com',
        gradient: const [Color(0xFF4E3CB5), Color(0xFF7B5FB8)],
        doctorImage:
            'assets/images/bruno-rodrigues-279xIHymPYY-unsplash-removebg-preview.png',
        doctorEmoji: '👨‍⚕️',
      ),
      _BannerData(
        title1: 'Online',
        title2: 'Consultation',
        description:
            'Connect with top doctors from the comfort of your home. Get expert advice anytime.',
        badge: 'Book Now',
        gradient: const [Color(0xFF0D4C92), Color(0xFF1A6BB5)],
        doctorImage:
            'assets/images/granderboy-doctor-2337835_1920-removebg-preview.png',
        doctorEmoji: '🩺',
      ),
      _BannerData(
        title1: 'Dental Care',
        title2: 'Specialists',
        description:
            'Expert dental care with modern technology. Painless treatments and beautiful smiles.',
        badge: 'Special Offer',
        gradient: const [Color(0xFF199A8E), Color(0xFF2BB5A8)],
        doctorImage:
            'assets/images/diana73-dentist-1191671_1920-removebg-preview.png',
        doctorEmoji: '🦷',
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 170,
          width: double.infinity,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() => _currentBannerIndex = index);
            },
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: banner.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Dotted pattern background
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CustomPaint(painter: DotPatternPainter()),
                        ),
                      ),
                      // Doctor image on the right
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          child: Image.asset(
                            banner.doctorImage,
                            width: 140,
                            height: 170,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 140,
                                height: 170,
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    banner.doctorEmoji,
                                    style: const TextStyle(fontSize: 90),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // Text content on the left
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              banner.title1,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              banner.title2,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 160,
                              child: Text(
                                banner.description,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white70,
                                  height: 1.3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF5252),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                banner.badge,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Pagination dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentBannerIndex == index ? 24 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentBannerIndex == index
                    ? AppColors.secondary
                    : AppColors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Best Specialist',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DoctorListScreen(),
                    ),
                  );
                },
                child: const Text(
                  'View More',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildSpecialistTabs(),
        const SizedBox(height: 16),
        _buildFilteredDoctors(),
      ],
    );
  }

  Widget _buildFilteredDoctors() {
    // Filter doctors based on selected specialty
    final filteredDoctors = sampleDoctors.where((doctor) {
      final specialty = doctor.specialty.toLowerCase();
      final selected = _selectedSpecialty.toLowerCase();

      if (selected == 'general') {
        return specialty.contains('general') || specialty.contains('physician');
      } else if (selected == 'dentist') {
        return specialty.contains('dentist');
      } else if (selected == 'nutrition') {
        return specialty.contains('nutrition');
      } else if (selected == 'pediatric') {
        return specialty.contains('pediatric') ||
            specialty.contains('pediatrician');
      }
      return false;
    }).toList();

    // If no doctors match, show first doctor as placeholder
    final doctorsToShow = filteredDoctors.isEmpty
        ? [sampleDoctors[0]]
        : filteredDoctors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: doctorsToShow.take(2).map((doctor) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorDetailScreen(doctor: doctor),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
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
                      size: 60,
                      borderRadius: 8,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor.specialty,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        color: AppColors.grey,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpecialistTabs() {
    final specialties = ['General', 'Dentist', 'Nutrition', 'Pediatric'];
    return SizedBox(
      height: 36,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          final isSelected = _selectedSpecialty == specialty;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedSpecialty = specialty;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.secondary : AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected ? AppColors.secondary : AppColors.lightGrey,
                ),
              ),
              child: Center(
                child: Text(
                  specialty,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.grey,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BannerData {
  final String title1;
  final String title2;
  final String description;
  final String badge;
  final List<Color> gradient;
  final String doctorImage;
  final String doctorEmoji;

  const _BannerData({
    required this.title1,
    required this.title2,
    required this.description,
    required this.badge,
    required this.gradient,
    required this.doctorImage,
    required this.doctorEmoji,
  });
}

// Custom painter for dotted pattern background
class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    const double spacing = 15;
    const double dotSize = 2;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
