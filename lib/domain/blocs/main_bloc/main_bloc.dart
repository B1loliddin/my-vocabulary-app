import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_vocabulary_app/domain/models/word_model.dart';
import 'package:my_vocabulary_app/services/database_service.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitialState(words: [])) {
    on<FetchAllWordsEvent>(_onFetchAllWords);
    on<FetchMyWordsEvent>(_onFetchMyWords);
  }

  Future<void> _onFetchAllWords(FetchAllWordsEvent event, Emitter emit) async {
    emit(MainLoadingState(words: state.words));

    final List<WordModel> words = await DatabaseService.readAllWords();

    emit(FetchAllWordsSuccessState(words: words));
  }

  Future<void> _onFetchMyWords(FetchMyWordsEvent event, Emitter emit) async {
    emit(MainLoadingState(words: state.words));

    final List<WordModel> words = await DatabaseService.readMyWords();

    emit(FetchMyWordsSuccessState(words: words));
  }
}
