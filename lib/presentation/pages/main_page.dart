import 'package:flutter/material.dart';
import 'package:my_vocabulary_app/presentation/pages/add_word_page.dart';
import 'package:my_vocabulary_app/presentation/pages/home_page.dart';
import 'package:my_vocabulary_app/presentation/pages/my_words_page.dart';
import 'package:my_vocabulary_app/presentation/pages/profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          HomePage(),
          MyWordsPage(),
          AddWordPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
