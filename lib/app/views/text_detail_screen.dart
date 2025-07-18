import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/text_controller.dart';
import '../models/level_model.dart';
import '../utils/responsive_utils.dart';

class TextDetailScreen extends GetView<TextController> {
  final Textoo text = Get.arguments;

  TextDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF6D4C41),
                      ),
                      onPressed: () => Get.back(),
                    )
                    .animate()
                    .scale(duration: 300.ms)
                    .shimmer(duration: 1200.ms, delay: 300.ms),
                title: Text(
                      text.name,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                          context,
                          24,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D4C41),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: 0.2, duration: 400.ms),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: ResponsiveUtils.getResponsivePadding(context),
                  child: Column(
                    children: [
                      Hero(
                            tag: 'text_image_${text.name}',
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  text.image,
                                  height: ResponsiveUtils.getResponsiveHeight(
                                    context,
                                    30,
                                  ),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Center(
                                            child: Icon(Icons.error),
                                          ),
                                ),
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .scale(delay: 200.ms)
                          .shimmer(duration: 1200.ms, delay: 1000.ms),
                      SizedBox(
                        height: ResponsiveUtils.getResponsiveSize(context, 20),
                      ),
                      Card(
                            elevation: 5,
                            color: Color(0xFFD7CCC8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: ResponsiveUtils.getResponsivePadding(
                                context,
                              ),
                              child: RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize:
                                        ResponsiveUtils.getResponsiveFontSize(
                                          context,
                                          20,
                                        ),
                                    color: Color(0xFF6D4C41),
                                    height: 1.8,
                                  ),
                                  children: _buildTextSpans(context),
                                ),
                              ),
                            ),
                          )
                          .animate()
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

  List<TextSpan> _buildTextSpans(BuildContext context) {
    List<TextSpan> spans = [];
    List<String> words = text.content.split(' ');

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final highlightedWord = text.highlightedWords.firstWhereOrNull(
        (hw) => hw.word.trim().toLowerCase() == word.trim().toLowerCase(),
      );

      if (highlightedWord != null) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
              color: Color(0xFF8D6E63),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    HapticFeedback.mediumImpact();
                    controller.selectWord(highlightedWord);
                  },
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
              color: Colors.black87,
              fontFamily: 'Cairo',
            ),
          ),
        );
      }
    }

    return spans;
  }
}
