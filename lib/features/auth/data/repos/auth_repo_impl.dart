import 'package:talk_to_me/constants.dart';
import 'package:talk_to_me/core/utils/api_service.dart';
import 'package:talk_to_me/core/utils/cache_service.dart';
import 'package:talk_to_me/core/utils/service_locator.dart';
import 'package:talk_to_me/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);

  String baseUrl = kBaseUrl;

  @override
  Future<void> login({required String email, required String password}) async {
    await apiService.post(
        url: '$baseUrl/auth/login',
        data: {'email': email, 'password': password}).then((value) {
      getIt<CacheService>().saveData(key: kTokenKey, value: value?['token']);
    });
  }

  @override
  Future<void> register(
      {required String username,
      required String email,
      required String password}) async {
    await apiService.post(url: '$baseUrl/auth/register', data: {
      'username': username,
      'email': email,
      'password': password
    }).then((value) {
      login(email: email, password: password);
    });
  }
}
