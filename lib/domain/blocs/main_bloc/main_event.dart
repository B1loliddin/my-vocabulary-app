part of 'main_bloc.dart';

@immutable
abstract class MainEvent {
  const MainEvent();
}

class FetchAllWordsEvent extends MainEvent {
  const FetchAllWordsEvent();
}

class FetchMyWordsEvent extends MainEvent {
  const FetchMyWordsEvent();
}
