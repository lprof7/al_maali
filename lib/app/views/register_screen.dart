import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'الاسم',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final error = await authController.register(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    confirmPasswordController.text.trim(),
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
                child: const Text('إنشاء حساب'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('لديك حساب؟ سجل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
