import 'package:flutter/material.dart';
import 'package:project/screens/login/login.dart';
import 'package:get/get.dart';
import 'controller/login_controller.dart';
import 'screens/home/nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final logInController = Get.put(LogInController());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Obx(() {
        return (logInController.isLoggedIn.value)
            ? const MainNavScreen()
            : const LogInPage();
      }),
    );
  }
}
