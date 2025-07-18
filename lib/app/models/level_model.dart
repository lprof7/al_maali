class Level {
  final int id;
  final String name;
  final String image;
  final List<Textoo> texts;

  Level({
    required this.id,
    required this.name,
    required this.image,
    required this.texts,
  });
}

class Textoo {
  final int id;
  final String name;
  final String content;
  final String image;
  final List<HighlightedWord> highlightedWords;

  Textoo({
    required this.id,
    required this.name,
    required this.content,
    required this.image,
    required this.highlightedWords,
  });
}

class HighlightedWord {
  final String word;
  final String image;
  final String description;
  final String audioPath;

  HighlightedWord({
    required this.word,
    required this.image,
    required this.description,
    required this.audioPath,
  });
}
