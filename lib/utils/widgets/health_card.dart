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
