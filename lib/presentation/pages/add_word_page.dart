import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_vocabulary_app/domain/blocs/word_bloc/word_bloc.dart';
import 'package:my_vocabulary_app/views/custom_text_field_view.dart';

class AddWordPage extends StatefulWidget {
  const AddWordPage({super.key});

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  late final TextEditingController wordController;
  late final TextEditingController translationController;
  late final TextEditingController definitionController;
  late final TextEditingController exampleController;
  late final ImagePicker picker;
  File? file;

  void _createWord(
    String word,
    String translation,
    String definition,
    String example,
  ) {
    BlocProvider.of<WordBloc>(context).add(
      CreateWordEvent(
        word: word,
        translation: translation,
        definition: definition,
        example: example,
        file: file!,
      ),
    );
  }

  Future<void> _getImage() async {
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    file = xFile != null ? File(xFile.path) : null;

    if (file != null && mounted) {
      BlocProvider.of<WordBloc>(context).add(
        ViewImageEvent(image: file!),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    wordController = TextEditingController();
    translationController = TextEditingController();
    definitionController = TextEditingController();
    exampleController = TextEditingController();
    picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// #main ui
        Scaffold(
          appBar: AppBar(title: const Text('Add Word Page')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 2),
                CustomTextFieldView(
                  controller: wordController,
                  hintText: 'Word',
                ),
                const SizedBox(height: 30),
                CustomTextFieldView(
                  controller: translationController,
                  hintText: 'Translation',
                ),
                const SizedBox(height: 30),
                CustomTextFieldView(
                  controller: definitionController,
                  hintText: 'Definition',
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                CustomTextFieldView(
                  controller: exampleController,
                  hintText: 'Example',
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _getImage,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: SizedBox(
                      height: 250,
                      child: Center(
                        child: BlocBuilder<WordBloc, WordState>(
                          builder: (context, state) {
                            if (state is ViewImageSuccessState) {
                              return ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                child: Image(
                                  image: FileImage(state.file),
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return const Icon(Icons.add, size: 60);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _createWord(
                wordController.text.trim(),
                translationController.text.trim(),
                definitionController.text.trim(),
                exampleController.text.trim(),
              );
            },
            child: const Icon(Icons.add),
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

  @override
  void dispose() {
    wordController.dispose();
    translationController.dispose();
    definitionController.dispose();
    exampleController.dispose();
    super.dispose();
  }
}
