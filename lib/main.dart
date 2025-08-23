import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/home_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fa')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier<ThemeMode>(
    ThemeMode.dark,
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeMode,
      builder: (context, value, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlue[50]),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.black,
              fontFamily: "Modam",
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
            labelLarge: TextStyle(
              color: Colors.black,
              fontFamily: "Modam",
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            labelMedium: TextStyle(
              color: Colors.black,
              fontFamily: "Modam",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodyMedium: TextStyle(
              color: Colors.black,
              fontFamily: "Modam",
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            displaySmall: TextStyle(
              color: Colors.grey,
              fontFamily: "Modam",
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightBlue[50]!,
            onSurface: Colors.lightBlue[50]!,
            onSurfaceVariant: Colors.white,
            brightness: Brightness.light,
            primary: Colors.lightBlue[50]!,
          ),
          fontFamily: "Modam",
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryIconTheme: IconThemeData(color: Colors.white),
          primaryColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            foregroundColor: Colors.white,
          ),
          colorScheme: ColorScheme.dark(
            brightness: Brightness.dark,
            surface: const Color.fromARGB(255, 14, 22, 33),
            onSurface: const Color.fromARGB(255, 24, 37, 51),
            onSurfaceVariant: Color.fromARGB(255, 36, 47, 61),
            primary: Color(0xFF4E6BFF),
          ),
          highlightColor: const Color.fromARGB(255, 181, 184, 191),
          fontFamily: "Modam",
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
              fontFamily: "Modam",
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
            labelLarge: TextStyle(
              color: Colors.white,
              fontFamily: "Modam",
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            labelMedium: TextStyle(
              color: Colors.white,
              fontFamily: "Modam",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontFamily: "Modam",
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            displaySmall: TextStyle(
              color: Colors.grey,
              fontFamily: "Modam",
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        themeMode: _themeMode.value,
        // home: HomeWidget(themeMode: _themeMode),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: child!,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeWidget(themeMode: _themeMode),
      ),
    );
  }
}
