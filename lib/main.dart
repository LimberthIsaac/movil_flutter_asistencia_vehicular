import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/main_screen.dart';
import 'pages/home_page.dart';
import 'pages/permission_page.dart';
import 'pages/request_assistance_page.dart';
import 'pages/searching_workshop_page.dart';
import 'pages/tracking_page.dart';
import 'pages/checkout_page.dart';
import 'pages/rating_page.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'AsistCar',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/forgot_password': (context) => const ForgotPasswordPage(),
          '/main': (context) => const MainScreen(),
          '/home': (context) => const HomePage(),
          '/permissions': (context) => const PermissionPage(),
          '/request': (context) => const RequestAssistancePage(),
          '/searching': (context) => const SearchingWorkshopPage(),
          '/tracking': (context) => const TrackingPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/rating': (context) => const RatingPage(),
        },
      ),
    );
  }
}
