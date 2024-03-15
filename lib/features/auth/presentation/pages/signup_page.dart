import 'package:blog_app/core/commons/widgets/loading_screen.dart';
import 'package:blog_app/core/utils/show_snackbar_message.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPagStateState();
}

class _SignUpPagStateState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
                    child: Text("Wohoo! Authentication successful"),
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
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 54,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthTextField(
                        controller: _nameController, hintText: "Name"),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthTextField(
                      isEmail: true,
                      controller: _emailController,
                      hintText: "Email",
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
                      title: "Sign Up",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUpProcessEvent(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ));
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an accout?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const SignInPage()));
                            },
                            child: Text(
                              "Sign In",
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
