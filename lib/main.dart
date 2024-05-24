import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_to_text_ocr/core/singleton/local_storage/local_storage.dart';
import 'package:image_to_text_ocr/features/home/presentation/pages/home_screen.dart';
import 'package:image_to_text_ocr/features/navigation/pages/navigation_screen.dart';
import 'package:image_to_text_ocr/features/settings/presentation/manager/settings/settings_cubit.dart';
import 'package:image_to_text_ocr/generated/l10n.dart';
import 'package:google_translator/google_translator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageShared.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsCubit()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: Colors.green.shade300)),
      darkTheme: ThemeData.dark().copyWith(colorScheme: ColorScheme.dark(primary: Colors.green.shade300)),
      title: "Image To Text OCR",
      themeMode: context.read<SettingsCubit>().isDarkMode,
      home: NavigationScreen(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: context.watch<SettingsCubit>().state.language.locale,
      supportedLocales: LanguageRepository.languages.map((e) => e.locale).toList(),
    );
  }
}
