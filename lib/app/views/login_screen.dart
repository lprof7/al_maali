import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final error = await authController.login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  if (error != null) {
                    Get.snackbar(
                      'خطأ',
                      error,
                      backgroundColor: Colors.red.shade100,
                    );
                  } else {
                    Get.offAllNamed('/levels');
                  }
                },
                child: const Text('تسجيل الدخول'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: const Text('ليس لديك حساب؟ أنشئ حسابًا'),
            ),
          ],
        ),
      ),
    );
  }
}
