import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterxpress_admin/app/modules/login/controllers/login_controller.dart';
import 'package:waterxpress_admin/app/routes/app_pages.dart';

class SplashscreenView extends StatelessWidget {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<LoginController>();

    Future.delayed(const Duration(seconds: 1), () {
      if (authC.isUserLoggedIn()) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF40C4FF), Color(0xFF0288D1), Color(0xFF40C4FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded to push content to the center
              const Spacer(flex: 2),

              // Centered CircleAvatar
              Center(
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('assets/images/logo2.png'),
                ),
              ),

              const SizedBox(height: 30),

              // Centered Progress Indicator
              const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),

              // Expanded to push content to the bottom
              const Spacer(flex: 2),

              // Centered Text
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "by CupCake Team",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
