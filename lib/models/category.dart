import 'package:flutter/material.dart';

class MedicalCategory {
  final String name;
  final IconData icon;
  final Color color;

  MedicalCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

List<MedicalCategory> categories = [
  MedicalCategory(
    name: 'Doctor',
    icon: Icons.medical_services,
    color: const Color(0xFF199A8E),
  ),
  MedicalCategory(
    name: 'Pharmacy',
    icon: Icons.local_pharmacy,
    color: const Color(0xFFFF6B6B),
  ),
  MedicalCategory(
    name: 'Hospital',
    icon: Icons.local_hospital,
    color: const Color(0xFFFFB800),
  ),
  MedicalCategory(
    name: 'Ambulance',
    icon: Icons.airport_shuttle,
    color: const Color(0xFF9B59B6),
  ),
];
