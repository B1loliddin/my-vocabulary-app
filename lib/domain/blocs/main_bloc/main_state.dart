part of 'main_bloc.dart';

@immutable
abstract class MainState {
  final List<WordModel> words;

  const MainState({required this.words});
}

class MainInitialState extends MainState {
  const MainInitialState({required super.words});
}

class MainLoadingState extends MainState {
  const MainLoadingState({required super.words});
}

class MainFailureState extends MainState {
  final String message;

  const MainFailureState({
    required super.words,
    required this.message,
  });
}

class FetchAllWordsSuccessState extends MainState {
  const FetchAllWordsSuccessState({required super.words});
}

class FetchMyWordsSuccessState extends MainState {
  const FetchMyWordsSuccessState({required super.words});
}
