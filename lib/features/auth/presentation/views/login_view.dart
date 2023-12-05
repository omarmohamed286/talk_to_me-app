import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_to_me/core/utils/app_routes.dart';
import 'package:talk_to_me/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:talk_to_me/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                CustomTextFormField(
                  labelText: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  labelText: 'Password',
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.homeView, (route) => false);
                    }
                  },
                  builder: (context, state) {
                    return state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: 'Login',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                BlocProvider.of<AuthCubit>(context)
                                    .login(email: email!, password: password!);
                              }
                            },
                          );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New User?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registerView);
                        },
                        child: const Text('Create Account'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
