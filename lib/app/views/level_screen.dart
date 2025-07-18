import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/level_controller.dart';
import '../controllers/auth_controller.dart';

class LevelScreen extends GetView<LevelController> {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEFEBE9), Color(0xFFD7CCC8)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 50),
                  Text(
                    'اختر المستوى',
                    style: GoogleFonts.cairo(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6D4C41),
                    ),
                  ).animate().fade(duration: const Duration(milliseconds: 300)),
                  IconButton(
                    onPressed: () async {
                      await authController.logout();
                      Get.offAllNamed('/');
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Color(0xFF6D4C41),
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.levels.length,
                    itemBuilder: (context, index) {
                      final level = controller.levels[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          elevation: 5,
                          color: Color(0xFFD7CCC8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                            onPressed: () => controller.selectLevel(level.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 0,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                Image.asset(level.image, height: 60, width: 60),
                                const SizedBox(width: 20),
                                Text(
                                  level.name,
                                  style: GoogleFonts.cairo(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6D4C41),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(
                            duration: const Duration(milliseconds: 300),
                          ),
                        ),
                      );
                    },
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
