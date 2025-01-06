/// A stateless widget that represents a health card with an icon, label, and value.
///
/// The [HealthCard] widget displays an icon, a label, and a value inside a styled container.
/// It is typically used to represent health-related information in a card format.
///
/// The [icon] parameter is required and specifies the icon to be displayed.
/// The [label] parameter is required and specifies the label text to be displayed.
/// The [value] parameter is required and specifies the value text to be displayed.
///
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const HealthCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.43.sw,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.grey,
          width: 0.5.r,
        ),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 36.h, color: Colors.blue),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 20.sp)),
        ],
      ),
    );
  }
}
