import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/features/home_screen/Presentation/View/Widget/home_banner_card.dart';
import 'package:tharadtech/features/home_screen/Presentation/View/Widget/training_info_section.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const HomeBannerCard(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: const TrainingInfoSection(),
            ),
          ],
        ),
      ),
    );
  }
}