import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:svs_superpago/pages/home_page.dart';
import 'package:svs_superpago/pages/payment_page.dart';
import 'pages/create_account_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        'ForgotPassword': (context) => const ForgotPassword(),
        'CreateAccount': (context) => const CreateAccount(),
        'HomePage': (context) => const HomePage(),
        'PaymentPage': (context) => const PaymentPage(),
      },
    );
  }
}
