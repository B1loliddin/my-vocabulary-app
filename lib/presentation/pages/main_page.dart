import 'package:flutter/material.dart';
import 'package:my_vocabulary_app/presentation/pages/add_word_page.dart';
import 'package:my_vocabulary_app/presentation/pages/home_page.dart';
import 'package:my_vocabulary_app/presentation/pages/my_words_page.dart';
import 'package:my_vocabulary_app/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (int index) => setState(() => currentIndex = index),
        children: const [
          HomePage(),
          MyWordsPage(),
          AddWordPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          controller.animateToPage(
            index,
            duration: const Duration(seconds: 1),
            curve: Curves.linear,
          );
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.privacy_tip),
            label: 'Private',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Word',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
