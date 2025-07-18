import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/text_controller.dart';
import '../utils/responsive_utils.dart';

class WordDetailScreen extends GetView<TextController> {
  const WordDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD7CCC8), Color(0xFFEFEBE9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF6D4C41),
                  ),
                  onPressed: () => Get.back(),
                ).animate()
                    .scale(duration: 300.ms)
                    .shimmer(duration: 1200.ms, delay: 300.ms),
                title: Text(
                  'تفاصيل الكلمة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6D4C41),
                  ),
                ).animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: 0.2, duration: 400.ms),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(
                    ResponsiveUtils.getResponsiveSize(context, 16),
                  ),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            controller.selectedWordImage.value,
                            height: ResponsiveUtils.getResponsiveHeight(context, 30),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                  child: Icon(Icons.error),
                                ),
                          ),
                        ),
                      ).animate()
                          .fadeIn(duration: 800.ms)
                          .scale(delay: 200.ms)
                          .shimmer(duration: 1200.ms, delay: 1000.ms),
                      SizedBox(
                        height: ResponsiveUtils.getResponsiveSize(context, 20),
                      ),
                      Card(
                        elevation: 5,
                        color: const Color(0xFFD7CCC8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            ResponsiveUtils.getResponsiveSize(context, 16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                controller.selectedWord.value,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(
                                    context,
                                    32,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6D4C41),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: ResponsiveUtils.getResponsiveSize(
                                  context,
                                  20,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => controller.playAudio(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6D4C41),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveUtils.getResponsiveSize(
                                      context,
                                      32,
                                    ),
                                    vertical: ResponsiveUtils.getResponsiveSize(
                                      context,
                                      16,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                icon: const Icon(Icons.play_arrow),
                                label: Text(
                                  'تشغيل الصوت',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: ResponsiveUtils.getResponsiveFontSize(
                                      context,
                                      18,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ResponsiveUtils.getResponsiveSize(
                                  context,
                                  20,
                                ),
                              ),
                              Text(
                                controller.selectedWordDescription.value,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(
                                    context,
                                    20,
                                  ),
                                  color: const Color(0xFF6D4C41),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ).animate()
                          .fadeIn(delay: 400.ms, duration: 800.ms)
                          .slideY(begin: 0.2, duration: 600.ms)
                          .then()
                          .shimmer(duration: 1200.ms),
                    ],
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
