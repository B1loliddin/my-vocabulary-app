class WordModel {
  final String id;
  final String userId;
  final String word;
  final String translation;
  final String definition;
  final String example;
  final String imageUrl;

  WordModel({
    required this.id,
    required this.userId,
    required this.word,
    required this.translation,
    required this.definition,
    required this.example,
    required this.imageUrl,
  });

  factory WordModel.fromJson(Map<String, Object?> json) {
    final String id = json['id'] as String;
    final String userId = json['userId'] as String;
    final String word = json['word'] as String;
    final String translation = json['translation'] as String;
    final String definition = json['definition'] as String;
    final String example = json['example'] as String;
    final String imageUrl = json['imageUrl'] as String;

    return WordModel(
      id: id,
      userId: userId,
      word: word,
      translation: translation,
      definition: definition,
      example: example,
      imageUrl: imageUrl,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'userId': userId,
      'word': word,
      'translation': translation,
      'definition': definition,
      'example': example,
      'imageUrl': imageUrl,
    };
  }

  WordModel copyWith({
    String? id,
    String? userId,
    String? word,
    String? translation,
    String? definition,
    String? example,
    String? imageUrl,
  }) {
    return WordModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      word: word ?? this.word,
      translation: translation ?? this.translation,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
