import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_to_text_ocr/core/constants/colors.dart';
import 'package:image_to_text_ocr/core/constants/images.dart';
import 'package:image_to_text_ocr/core/constants/text_styles.dart';
import 'package:image_to_text_ocr/features/settings/presentation/manager/settings/settings_cubit.dart';
import 'package:image_to_text_ocr/features/settings/presentation/pages/language_screen.dart';
import 'package:image_to_text_ocr/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(8),
                ProfileItem(
                  title: S.of(context).language,
                  icon: AppImages.languageCircle,
                  subtitle: state.locale,
                  onTap: () => context.push(const LanguageScreen()),
                ),
                Gap(16),
                ProfileItem(
                  title: S.of(context).themeMode,
                  icon: AppImages.languageCircle,
                  subtitle: state.darkMode ? S.of(context).dark : S.of(context).light,
                  rightWidget: Switch.adaptive(
                    value: state.darkMode,
                    onChanged: (value) => context.read<SettingsCubit>().toggleDarkMode(value),
                  ),
                  onTap: () => context.read<SettingsCubit>().toggleDarkMode(!state.darkMode),
                  // onTap: () => context.push(const LanguageScreen()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    this.titleColor,
    required this.icon,
    this.subtitle,
    required this.onTap,
    this.rightWidget,
  });

  final VoidCallback onTap;
  final Widget? rightWidget;
  final String icon;
  final String title;
  final Color? titleColor;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: subtitle == null ? 16 : 8),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(titleColor ?? AppColors.greyscale900, BlendMode.srcIn),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title, style: AppTextStyle.subtitleS1Medium.copyWith(color: titleColor)),
                  if (subtitle != null)
                    Text(subtitle!, style: AppTextStyle.otherCaption.copyWith(color: AppColors.greyscale400)),
                ],
              ),
            ),
            if (rightWidget != null) rightWidget!,
          ],
        ),
      ),
    );
  }
}
