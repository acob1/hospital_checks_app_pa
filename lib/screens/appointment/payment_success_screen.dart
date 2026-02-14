import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/colors.dart';
import '../../widgets/doctor_image.dart';
import '../../models/doctor.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Doctor doctor;
  final DateTime date;
  final String time;
  final String type;

  const PaymentSuccessScreen({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              _buildSuccessAnimation(),
              const SizedBox(height: 32),
              const Text(
                'Appointment Confirm',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Payment Successful',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 32),
              _buildDoctorInfo(),
              const SizedBox(height: 24),
              _buildAppointmentSchedule(),
              const SizedBox(height: 24),
              _buildServiceLocation(),
              const Spacer(),
              _buildViewAppointmentButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            right: 10,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          DoctorImage(
            imagePath: doctor.image,
            size: 60,
            borderRadius: 12,
          ),
          const SizedBox(width: 12),
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
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.grey.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'MD, MS, MBBS',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentSchedule() {
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Appointment Schedule',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd MMM yyyy').format(date),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceLocation() {
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Service Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            doctor.hospital,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '602, Midas Square Mall, Near Velly Fountain Resort, London, UK.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAppointmentButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Navigate back to home or appointments screen
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'View Appointment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
