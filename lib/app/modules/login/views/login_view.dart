import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterxpress_admin/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF40C4FF),
              Color(0xFF0288D1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 400,
                padding: const EdgeInsets.only(top: 75, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Selamat Datang Admin!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container bawah untuk form login
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0288D1),
                      blurRadius: 10,
                      offset: Offset(5, 8),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 20.0),
                      child: Text(
                        'Masuk dengan akun Anda!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF0277BD),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Field Email
                    Container(
                      decoration: textFieldDecoration(),
                      child: TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(
                            color: Color(0xFF37474F),
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.transparent,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFF0277BD),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Field Password
                    Container(
                      decoration: textFieldDecoration(),
                      child: Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.obscureText.value,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Color(0xFF37474F),
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.key,
                              color: Color(0xFF0277BD),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF0277BD),
                              ),
                              onPressed: () => controller.togglePasswordView(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 23),
                    // Tombol Login
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF40C4FF),
                              Color(0xFF0288D1),
                              // Color(0xFF26C6DA)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => controller.login(
                            controller.emailController.text,
                            controller.passwordController.text,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 270),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration textFieldDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    gradient: const LinearGradient(
      colors: [
        Color(0xFFB3E5FC),
        Color(0xFF81D4FA),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
