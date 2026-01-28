import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharadtech/core/helper/app_locclization.dart';
import 'package:tharadtech/features/App_Localization/Data/app_localization_cubit.dart';

class LanguageBottomSheet extends StatefulWidget {
  final AppLocalizations localization;

  const LanguageBottomSheet({
    super.key,
    required this.localization,
  });

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String currentLang = "ar";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.localization.translate('language') ?? "اللغة",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 20.h),
          LanguageItem(
            label: widget.localization.translate('arabic') ?? "العربية",
            isSelected: currentLang == "ar",
            onTap: () => setState(() => currentLang = "ar"),
          ),
          SizedBox(height: 10.h),
          LanguageItem(
            label: widget.localization.translate('english') ?? "English",
            isSelected: currentLang == "en",
            onTap: () => setState(() => currentLang = "en"),
          ),
          SizedBox(height: 25.h),
          ApplyButton(
            lang: currentLang,
            localization: widget.localization,
          ),
        ],
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1B523D) : Colors.grey[200]!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF1B523D) : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplyButton extends StatelessWidget {
  final String lang;
  final AppLocalizations localization;

  const ApplyButton({
    super.key,
    required this.lang,
    required this.localization,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B523D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: () {

          final cubit = context.read<AppLocalizationCubit>();
          cubit.changeLanguage(lang == "ar" ? LanguageEvent.arabicLanguage : LanguageEvent.englishLanguage);
          Navigator.pop(context);
        },
        child: Text(
          localization.translate('apply') ?? "تطبيق",
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
    );
  }
}
