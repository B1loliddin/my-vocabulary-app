import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/main_bloc/main_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/word_bloc/word_bloc.dart';
import 'package:my_vocabulary_app/presentation/pages/main_page.dart';
import 'package:my_vocabulary_app/presentation/pages/sign_in_page.dart';
import 'package:my_vocabulary_app/services/auth_service.dart';

class MyVocabularyApp extends StatelessWidget {
  const MyVocabularyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<MainBloc>(create: (context) => MainBloc()),
        BlocProvider<WordBloc>(create: (context) => WordBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.light,
        home: StreamBuilder<User?>(
          initialData: null,
          stream: AuthService.auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return const MainPage();
            }

            return const SignInPage();
          },
        ),
      ),
    );
  }
}
