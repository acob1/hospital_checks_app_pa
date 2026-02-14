import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/colors.dart';
import '../main_screen.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  const CompleteRegistrationScreen({super.key});

  @override
  State<CompleteRegistrationScreen> createState() =>
      _CompleteRegistrationScreenState();
}

class _CompleteRegistrationScreenState
    extends State<CompleteRegistrationScreen> {
  final _phoneController = TextEditingController();
  String _selectedCountryCode = '+91';
  String _selectedCountry = 'India';
  String _selectedGender = 'Male';
  DateTime? _selectedDate;

  final List<String> _countries = [
    'India',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
  ];

  final List<String> _genders = ['Male', 'Female', 'Other'];

  final Map<String, String> _countryCodes = {
    'India': '+91',
    'United States': '+1',
    'United Kingdom': '+44',
    'Canada': '+1',
    'Australia': '+61',
    'Germany': '+49',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2FA),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Complete Registration',
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mobile Number
            _buildLabel('Mobile Number'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.12),
                ),
              ),
              child: Row(
                children: [
                  // Country code selector
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: AppColors.secondary.withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🇮🇳', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 4),
                        Text(
                          _selectedCountryCode,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.secondary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  // Phone number input
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: '88440 04488',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey.withValues(alpha: 0.5),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Select Country
            _buildLabel('Select Country'),
            const SizedBox(height: 8),
            _buildDropdown(
              value: _selectedCountry,
              items: _countries,
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value!;
                  _selectedCountryCode =
                      _countryCodes[_selectedCountry] ?? '+91';
                });
              },
            ),
            const SizedBox(height: 24),

            // Select Gender
            _buildLabel('Select Gender'),
            const SizedBox(height: 8),
            _buildDropdown(
              value: _selectedGender,
              items: _genders,
              onChanged: (value) {
                setState(() => _selectedGender = value!);
              },
            ),
            const SizedBox(height: 24),

            // Date Of Birth
            _buildLabel('Date Of Birth'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? DateFormat('dd MMM yyyy').format(_selectedDate!)
                          : '20 Jan 1986',
                      style: TextStyle(
                        fontSize: 14,
                        color: _selectedDate != null
                            ? AppColors.black
                            : AppColors.grey.withValues(alpha: 0.5),
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: AppColors.secondary,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1986, 1, 20),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.secondary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: AppColors.grey.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.12),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.secondary,
          ),
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.black,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
