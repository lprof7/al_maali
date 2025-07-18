import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/level_model.dart';
import '../controllers/level_controller.dart';
import '../utils/responsive_utils.dart';

class TextsScreen extends GetView<LevelController> {
  const TextsScreen({Key? key}) : super(key: key);

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
                ),
                title: Text(
                  'اختر النص',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 24),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6D4C41),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getResponsiveSize(context, 16),
                  vertical: ResponsiveUtils.getResponsiveSize(context, 8),
                ),
                child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                          ),
                          decoration: InputDecoration(
                            hintText: 'ابحث عن النص...',
                            hintStyle: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Color(0xFF8D6E63),
                            ),
                            border: InputBorder.none,
                            icon: const Icon(
                              Icons.search,
                              color: Color(0xFF6D4C41),
                            ),
                            suffixIcon: Obx(
                              () => controller.searchQuery.value.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                      onPressed: controller.clearSearch,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                          onChanged: controller.searchTexts,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.2, duration: 400.ms),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.searchQuery.value.isNotEmpty) {
                    return _buildSearchResults(context);
                  }
                  final level = controller.levels.firstWhere(
                    (l) => l.id == controller.selectedLevel.value,
                  );
                  return _buildTextGrid(context, level.texts);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return Obx(() {
      if (controller.searchResults.isEmpty) {
        return Center(
          child: Text(
            'لا توجد نتائج',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
              color: const Color(0xFF6D4C41),
            ),
          ).animate().fadeIn(duration: 300.ms).scale(duration: 300.ms),
          );
      }
      return _buildTextGrid(context, controller.searchResults);
    });
  }

  Widget _buildTextGrid(BuildContext context, List<Textoo> texts) {
    return GridView.builder(
      padding: EdgeInsets.all(ResponsiveUtils.getResponsiveSize(context, 16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: ResponsiveUtils.getResponsiveSize(context, 16),
        mainAxisSpacing: ResponsiveUtils.getResponsiveSize(context, 16),
      ),
      itemCount: texts.length,
      itemBuilder: (context, index) {
        final text = texts[index];
        return Hero(
              tag: 'text_image_${text.name}',
              child: Card(
                elevation: 5,
                color: const Color(0xFFD7CCC8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () => Get.toNamed('/text-detail', arguments: text),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            text.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(
                            ResponsiveUtils.getResponsiveSize(context, 8),
                          ),
                          child: Text(
                            text.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6D4C41),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 100 * index))
            .scale(delay: Duration(milliseconds: 100 * index));
      },
    );
  }
}
