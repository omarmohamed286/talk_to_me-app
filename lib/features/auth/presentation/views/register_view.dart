import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_to_me/core/utils/app_routes.dart';
import 'package:talk_to_me/core/widgets/custom_button.dart';
import 'package:talk_to_me/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';

import 'widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? username, email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register"),
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
                  labelText: 'Username',
                  onChanged: (value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 30,
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
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.homeView);
                    }
                  },
                  builder: (context, state) {
                    return state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: 'Register',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                BlocProvider.of<AuthCubit>(context).register(
                                    username: username!,
                                    email: email!,
                                    password: password!);
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
                    const Text('Old user?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Login'))
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
