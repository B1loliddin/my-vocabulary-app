import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_vocabulary_app/presentation/pages/sign_in_page.dart';
import 'package:my_vocabulary_app/views/custom_text_field_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController userNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void _navigateToSignInPage({String? email, String? password}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignInPage(
          email: email,
          password: password,
        ),
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

  void _signUp() {
    BlocProvider.of<AuthBloc>(context).add(
      SignUpEvent(
        userName: userNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
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
          } else if (state is SignUpSuccessState) {
            _navigateToSignInPage(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// #sign up text
                  Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),

                  CustomTextFieldView(
                    controller: userNameController,
                    hintText: 'Username',
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldView(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldView(
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldView(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                  ),
                  const SizedBox(height: 30),

                  /// #sign up button
                  ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 30),

                  /// #already have an account text
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        const TextSpan(
                          text: 'Already have an account, ',
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.lightBlueAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _navigateToSignInPage,
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
