import 'package:flutter/material.dart';
import 'package:talk_to_me/core/utils/service_locator.dart';
import 'package:talk_to_me/features/auth/data/repos/auth_repo_impl.dart';
import 'package:talk_to_me/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/views/home_view.dart';

class AppRoutes {
  static const String loginView = '/loginView';
  static const String registerView = '/registerView';
  static const String homeView = '/homeView';

  static Map<String, Widget Function(BuildContext)> routes = {
    loginView: (context) => BlocProvider(
          create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
          child: const LoginView(),
        ),
    registerView: (context) => BlocProvider(
          create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
          child: const RegisterView(),
        ),
    homeView: (context) => const HomeView(),
  };
}
