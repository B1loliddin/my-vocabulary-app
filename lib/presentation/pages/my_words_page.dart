import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/main_bloc/main_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/word_bloc/word_bloc.dart';
import 'package:my_vocabulary_app/domain/models/word_model.dart';

class MyWordsPage extends StatefulWidget {
  const MyWordsPage({super.key});

  @override
  State<MyWordsPage> createState() => _MyWordsPageState();
}

class _MyWordsPageState extends State<MyWordsPage> {
  void _getData() => BlocProvider.of<MainBloc>(context).add(
        const FetchMyWordsEvent(),
      );

  void _showErrorMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _deleteWord(String wordId) => BlocProvider.of<WordBloc>(context).add(
        DeleteWordEvent(wordId: wordId),
      );

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// #main ui
        Scaffold(
          appBar: AppBar(
            title: const Text('My Words Page'),
          ),
          body: BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {
              if (state is FetchMyWordsSuccessState ||
                  state is UpdateWordEvent ||
                  state is DeleteWordEvent) {
                _getData();
              } else if (state is MainFailureState) {
                _showErrorMessage(state.message);
              }
            },
            builder: (context, state) {
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.words.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final WordModel wordModel = state.words[index];

                  return state.words.isNotEmpty
                      ? Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: ListTile(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            onLongPress: () {
                              _deleteWord(wordModel.id);
                            },
                            title: Text(
                              '${wordModel.word} - ${wordModel.translation}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              wordModel.definition,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      : Text(
                          'Empty',
                          style: Theme.of(context).textTheme.headlineSmall,
                        );
                },
              );
            },
          ),
        ),

        /// #laoding...
        BlocBuilder<WordBloc, WordState>(
          builder: (context, state) {
            if (state is WordLoadingState) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
