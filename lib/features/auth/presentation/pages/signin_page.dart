import 'package:blog_app/core/commons/widgets/loading_screen.dart';
import 'package:blog_app/core/utils/show_snackbar_message.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPagStateState();
}

class _SignInPagStateState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case AuthLoadingState:
                  return const LoadingScreen();

                case AuthSuccessState:
                  return const Center(
                    child: Text("Wohoo! Signin - Authentication successful"),
                  );

                case AuthFailureState:
                  final AuthFailureState failureState =
                      state as AuthFailureState;
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showSnackBar(context, failureState.errorMessage));
                  return const Center(
                    child: Text("Something went worng"),
                  );

                default:
                  const Center(
                    child: Text("Something went worng from default"),
                  );
              }
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 54,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthTextField(
                      controller: _emailController,
                      hintText: "Email",
                      isEmail: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthGradientButton(
                      title: "Sign In",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignInProcessEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an accout?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const SignUpPage()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ))
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
