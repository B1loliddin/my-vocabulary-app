part of 'word_bloc.dart';

@immutable
abstract class WordState {
  const WordState();
}

class WordInitialState extends WordState {
  const WordInitialState();
}

class WordLoadingState extends WordState {
  const WordLoadingState();
}

class WordFailureState extends WordState {
  final String message;

  const WordFailureState({required this.message});
}

class CreateWordSuccessState extends WordState {
  const CreateWordSuccessState();
}

class UpdateWordSuccessState extends WordState {
  const UpdateWordSuccessState();
}

class DeleteWordSuccessState extends WordState {
  const DeleteWordSuccessState();
}

class ViewImageSuccessState extends WordState {
  final File file;

  const ViewImageSuccessState({required this.file});
}
