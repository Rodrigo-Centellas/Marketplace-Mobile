import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'routes.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Stripe con tu clave publicable
  Stripe.publishableKey = "pk_test_51PO6ezHwTsOjjUFRDSjNeJHa5wmqQglGILhclU0RWRhliZQGWUoEzWzseiHrFwBit9kTBunMhPqBIxanAxPZLsA400Be6HYaGg";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

