import 'package:get_it/get_it.dart';
import 'package:talk_to_me/core/utils/api_service.dart';
import 'package:talk_to_me/core/utils/cache_service.dart';
import 'package:talk_to_me/core/utils/socket_service.dart';
import 'package:talk_to_me/features/auth/data/repos/auth_repo_impl.dart';
import 'package:talk_to_me/features/home/data/repos/home_repo_impl.dart';
import 'package:talk_to_me/features/home/data/repos/user_data_repo/user_data_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService());

  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIt<ApiService>()));
  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt<ApiService>()));
  getIt.registerSingleton<UserDataRepoImpl>(
      UserDataRepoImpl(getIt<ApiService>()));

  getIt.registerSingleton<CacheService>(CacheService());
  getIt.registerSingleton<SocketService>(SocketService());
}
