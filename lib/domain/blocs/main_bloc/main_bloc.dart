import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_vocabulary_app/domain/models/word_model.dart';
import 'package:my_vocabulary_app/services/database_service.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitialState(words: [])) {
    on<FetchAllWordsEvent>(_onFetchAllPosts);
    on<FetchMyWordsEvent>(_onFetchMyPosts);
  }

  Future<void> _onFetchAllPosts(FetchAllWordsEvent event, Emitter emit) async {
    emit(MainLoadingState(words: state.words));

    final List<WordModel> words = await DatabaseService.readAllWords();

    if (words.isNotEmpty) {
      emit(FetchAllWordsSuccessState(words: words));
    } else {
      emit(MainFailureState(words: state.words, message: 'Can not get words'));
    }
  }

  Future<void> _onFetchMyPosts(FetchMyWordsEvent event, Emitter emit) async {
    emit(MainLoadingState(words: state.words));

    final List<WordModel> words = await DatabaseService.readMyWords();

    if (words.isNotEmpty) {
      emit(FetchMyWordsSuccessState(words: words));
    } else {
      emit(MainFailureState(words: state.words, message: 'Can not get words'));
    }
  }
}
