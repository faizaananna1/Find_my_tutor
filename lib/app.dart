import 'package:flutter/material.dart';
import 'package:findmytutor/widgets/app_colors.dart';
import 'package:findmytutor/screens/home_screen.dart';
import 'package:findmytutor/screens/contact_screen.dart';
import 'package:findmytutor/screens/cv_screen.dart';
import 'package:findmytutor/screens/splash_screen.dart';

/// The root widget of the FindMyTutor application.
///
/// Sets up the [MaterialApp] with theme configuration, font family,
/// and the [MainShell] as the home screen.
class FindMyTutorApp extends StatelessWidget {
  const FindMyTutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find My Tutor',
      theme: ThemeData(
        fontFamily: 'InterDisplay',
        scaffoldBackgroundColor: AppColors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            elevation: WidgetStateProperty.all(0),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          enableFeedback: false,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.teal,
          surface: AppColors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

/// The main navigation shell of the app.
///
/// Contains a [BottomNavigationBar] with three tabs (Home, Contact, CV)
/// and uses an [IndexedStack] to preserve the state of each tab's screen.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  /// The list of screens corresponding to each bottom nav tab.
  final List<Widget> _screens = const [
    HomeScreen(),
    ContactScreen(),
    CvScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.teal,
        unselectedItemColor: AppColors.dark.withValues(alpha: 0.4),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_outlined),
            activeIcon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
