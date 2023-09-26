import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_vocabulary_app/presentation/pages/main_page.dart';
import 'package:my_vocabulary_app/presentation/pages/sign_up_page.dart';
import 'package:my_vocabulary_app/views/custom_text_field_view.dart';

class SignInPage extends StatefulWidget {
  final String? email;
  final String? password;

  const SignInPage({super.key, this.email, this.password});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
  }

  void _signIn() {
    BlocProvider.of<AuthBloc>(context).add(
      SignInEvent(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  void _navigateToMainPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _navigateToSignUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailureState) {
            _showErrorMessage(context, state.message);
          } else if (state is SignInSuccessState) {
            _navigateToMainPage();
          }
        },
        child: Stack(
          children: [
            /// #main ui
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// #sign in text
                  Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),

                  /// #email text field
                  CustomTextFieldView(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 20),

                  /// #password text field
                  CustomTextFieldView(
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 30),

                  /// #sign in button
                  ElevatedButton(
                    onPressed: _signIn,
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 30),

                  /// #already have account text
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account, ',
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.lightBlueAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _navigateToSignUpPage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// #laoding...
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingState) {
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
        ),
      ),
    );
  }
}
