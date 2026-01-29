import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';

class TrainingInfoSection extends StatelessWidget {
  const TrainingInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization.translate('about_training_title') ?? "عن التدريب",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D140D),
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          localization.translate('about_training_desc') ?? "",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[700],
            height: 1.5,
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          localization.translate('work_nature_title') ?? "طبيعة الشغل أثناء التدريب",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: 15.h),
        ..._buildFeatureList(localization, [
          "feature_1",
          "feature_2",
          "feature_3",
          "feature_4",
          "feature_5",
        ]),
      ],
    );
  }

  List<Widget> _buildFeatureList(AppLocalizations loc, List<String> keys) {
    return keys.map((key) => Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          CircleAvatar(radius: 6.r, backgroundColor: const Color(0xFF4EB0AD)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              loc.translate(key) ,
              style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal'),
            ),
          ),
        ],
      ),
    )).toList();
  }
}