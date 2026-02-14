import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/doctor_image.dart';
import '../../models/doctor.dart';
import 'package:intl/intl.dart';
import 'confirm_booking_screen.dart';

class AppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  const AppointmentScreen({super.key, required this.doctor});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  String _appointmentType = 'Online';
  final String _selectedPatient = 'My Self';
  final TextEditingController _problemController = TextEditingController();

  final List<String> timeSlots = [
    '9:00 AM', '9:15 AM', '9:30 AM', '9:45 AM',
    '10:00 AM', '10:15 AM', '10:30 AM', '10:45 AM',
    '11:00 AM', '11:15 AM', '11:30 AM', '11:45 AM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Booking',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorInfo(),
            const SizedBox(height: 20),
            _buildDateSelector(),
            const SizedBox(height: 20),
            _buildTimeSelector(),
            const SizedBox(height: 20),
            _buildAppointmentType(),
            const SizedBox(height: 20),
            _buildPatientSelector(),
            const SizedBox(height: 20),
            _buildProblemInput(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(context),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.white,
      child: Row(
        children: [
          DoctorImage(
            imagePath: widget.doctor.image,
            size: 60,
            borderRadius: 12,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.doctor.specialty,
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

  Widget _buildDateSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              Text(
                DateFormat('MMMM yyyy').format(_selectedDate),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final isSelected = DateFormat('dd').format(date) == DateFormat('dd').format(_selectedDate);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.secondary : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E').format(date),
                          style: TextStyle(
                            fontSize: 13,
                            color: isSelected ? Colors.white : AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat('dd').format(date),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Time',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              final time = timeSlots[index];
              final isSelected = _selectedTime == time;
              final isPast = index < 4; // First 4 slots are grayed out
              return GestureDetector(
                onTap: isPast ? null : () {
                  setState(() {
                    _selectedTime = time;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondary
                        : (isPast ? AppColors.background : AppColors.background),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.secondary
                          : (isPast ? AppColors.lightGrey : AppColors.lightGrey),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? Colors.white
                            : (isPast ? AppColors.grey.withValues(alpha: 0.4) : AppColors.grey),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appointment Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTypeButton('Online'),
              const SizedBox(width: 12),
              _buildTypeButton('At Clinic'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String type) {
    final isSelected = _appointmentType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _appointmentType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary : AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.white : AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Patient',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedPatient,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explain Your Problem Briefly',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 100,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _problemController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Describe your problem...',
                hintStyle: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: (_selectedTime != null)
                ? () {
                    _showConfirmBookingScreen(context);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              disabledBackgroundColor: AppColors.grey.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Confirm Booking',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmBookingScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmBookingScreen(
          doctor: widget.doctor,
          date: _selectedDate,
          time: _selectedTime!,
          type: _appointmentType,
        ),
      ),
    );
  }
}
