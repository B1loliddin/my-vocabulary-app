part of 'word_bloc.dart';

@immutable
abstract class WordEvent {
  const WordEvent();
}

class CreateWordEvent extends WordEvent {
  final String word;
  final String translation;
  final String definition;
  final String example;
  final File file;

  const CreateWordEvent({
    required this.word,
    required this.translation,
    required this.definition,
    required this.example,
    required this.file,
  });
}

class UpdateWordEvent extends WordEvent {
  final String wordId;
  final String word;
  final String translation;
  final String definition;
  final String example;
  final String imageUrl;

  const UpdateWordEvent({
    required this.wordId,
    required this.word,
    required this.translation,
    required this.definition,
    required this.example,
    required this.imageUrl,
  });
}

class DeleteWordEvent extends WordEvent {
  final String wordId;

  const DeleteWordEvent({required this.wordId});
}

class ViewImageEvent extends WordEvent {
  final File image;

  const ViewImageEvent({required this.image});
}
