import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/core/utils/app_color.dart';

class TrainingInfoSection extends StatelessWidget {
  const TrainingInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.translate('about_training_title'),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D140D),
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            localization.translate('about_training_desc'),
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xff998C8C),            height: 1.5,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            localization.translate('work_nature_title') ,
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
      ),
    );
  }

  List<Widget> _buildFeatureList(AppLocalizations loc, List<String> keys) {
    return keys.map((key) => Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
         Container(
           height: 16.h,
           width: 16.w,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             gradient:  LinearGradient(
               colors: [Color(AppColor.primaryColor), Color(0xFF54B7BB)],
               begin: AlignmentDirectional.centerStart,
               end:  AlignmentDirectional.centerEnd,
             ),
           ),
         ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              loc.translate(key) ,
              style: TextStyle(fontSize: 14.sp, fontFamily: 'Tajawal',color: Color(0xff998C8C)),
            ),
          ),
        ],
      ),
    )).toList();
  }
}