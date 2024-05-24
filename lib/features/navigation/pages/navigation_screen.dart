import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_to_text_ocr/core/constants/colors.dart';
import 'package:image_to_text_ocr/features/home/presentation/pages/home_screen.dart';
import 'package:image_to_text_ocr/features/navigation/manager/navigation_cubit.dart';
import 'package:image_to_text_ocr/features/settings/presentation/pages/settings_screen.dart';
import 'package:image_to_text_ocr/generated/l10n.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // List<Widget> screens = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, index) {
          return Scaffold(
            body: IndexedStack(
              index: index,
              children: const [
                HomeScreen(),
                SettingsScreen(),
              ],
            ),
            bottomNavigationBar: Localizations.override(
              context: context,
              child: BottomNavigationBar(
                unselectedItemColor: AppColors.greyscale400,
                selectedItemColor: AppColors.brandColor500Default,
                onTap: (value) => context.read<NavigationCubit>().changePage(value),
                currentIndex: index,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: S.of(context).home,
                  ),
                  
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.settings),
                    label: S.of(context).settings,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
