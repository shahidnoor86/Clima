import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: Colors.white),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 18, color: Colors.white)),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade200),
        ),
      ],
    );
  }
}
