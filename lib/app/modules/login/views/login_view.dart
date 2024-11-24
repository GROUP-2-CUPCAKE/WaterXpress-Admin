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
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
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
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
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
                          color: Color(0xFF0288D1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Field Email
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 192, 227, 244),
                            Color.fromARGB(255, 144, 200, 233),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(
                            color: Color(0xFF0288D1),
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.transparent,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFF0288D1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Field Password
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 192, 227, 244),
                            Color.fromARGB(255, 144, 200, 233),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.obscureText.value,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Color(0xFF0288D1),
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFF0288D1),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF0288D1),
                              ),
                              onPressed: () => controller.togglePasswordView(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
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
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => controller.login(
                            controller.emailController.text,
                            controller.passwordController.text,
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
