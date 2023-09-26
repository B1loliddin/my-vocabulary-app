import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_vocabulary_app/services/database_service.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc() : super(const WordInitialState()) {
    on<CreateWordEvent>(_onCreateWord);
    on<UpdateWordEvent>(_onUpdateWord);
    on<DeleteWordEvent>(_onDeleteWord);
    on<ViewImageEvent>(_onViewImage);
  }

  Future<void> _onCreateWord(CreateWordEvent event, Emitter emit) async {
    emit(const WordLoadingState());

    final bool isWordCreated = await DatabaseService.createWord(
      word: event.word,
      translation: event.translation,
      definition: event.definition,
      example: event.example,
      file: event.file,
    );

    if (isWordCreated) {
      emit(const CreateWordSuccessState());
    } else {
      emit(const WordFailureState(message: 'Can not create the word'));
    }
  }

  Future<void> _onUpdateWord(UpdateWordEvent event, Emitter emit) async {
    emit(const WordLoadingState());

    final bool isWordUpdated = await DatabaseService.updatePost(
      wordId: event.wordId,
      word: event.word,
      translation: event.translation,
      definition: event.definition,
      example: event.example,
      imageUrl: event.imageUrl,
    );

    if (isWordUpdated) {
      emit(const UpdateWordSuccessState());
    } else {
      emit(const WordFailureState(message: 'Can not update the word'));
    }
  }

  Future<void> _onDeleteWord(DeleteWordEvent event, Emitter emit) async {
    emit(const WordLoadingState());

    final bool isWordDeleted = await DatabaseService.deleteWord(event.wordId);

    if (isWordDeleted) {
      emit(const DeleteWordSuccessState());
    } else {
      emit(const WordFailureState(message: 'Can not update the word'));
    }
  }

  void _onViewImage(ViewImageEvent event, Emitter emit) =>
      emit(ViewImageSuccessState(file: event.image));
}
