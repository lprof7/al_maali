import 'package:get/get.dart';
import '../models/level_model.dart';
import 'package:audioplayers/audioplayers.dart';

class TextController extends GetxController {
  final audioPlayer = AudioPlayer();
  final RxString selectedWord = ''.obs;
  final RxString selectedWordImage = ''.obs;
  final RxString selectedWordDescription = ''.obs;
  final RxString selectedWordAudio = ''.obs;

  void selectWord(HighlightedWord word) {
    selectedWord.value = word.word;
    selectedWordImage.value = word.image;
    selectedWordDescription.value = word.description;
    selectedWordAudio.value = word.audioPath;
    Get.toNamed('/word-details');
  }

  Future<void> playAudio() async {
    try {
      String audioPath = selectedWordAudio.value;
      if (audioPath.startsWith('assets/')) {
        audioPath = audioPath.replaceFirst('assets/', '');
      }
      await audioPlayer.play(AssetSource(audioPath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
