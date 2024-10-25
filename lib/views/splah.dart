import 'package:code_lab3apps/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Mengatur posisi di tengah
          children: [
            ElevatedButton(
              child: Text("Register"),
              onPressed: () {
                Get.toNamed(Routes.REGISTER); // Navigasi ke halaman Register
              },
            ),
            SizedBox(height: 20), // Jarak antara tombol
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Get.toNamed(Routes.LOGIN); // Navigasi ke halaman Login
              },
            ),
          ],
        ),
      ),
    );
  }
}
