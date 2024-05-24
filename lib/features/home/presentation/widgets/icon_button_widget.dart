import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_to_text_ocr/core/constants/colors.dart';
import 'package:image_to_text_ocr/features/settings/presentation/manager/settings/settings_cubit.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const IconButtonWidget({
    required this.icon,
    required this.label,
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: context.watch<SettingsCubit>().state.darkMode ? AppColors.greyscale900 : Colors.white70,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyscale200),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 50,
                width: 50,
                decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.blue.shade900),
                child: Icon(icon, color: Colors.white)),
            Gap(8),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
