import 'package:talk_to_me/constants.dart';
import 'package:talk_to_me/core/models/user_model.dart';

import '../../../../../core/utils/api_service.dart';
import 'user_data_repo.dart';

class UserDataRepoImpl extends UserDataRepo {
  final ApiService apiService;

  UserDataRepoImpl(this.apiService);

  String baseUrl = kBaseUrl;

  @override
  Future<UserModel> getUser({required String token}) async {
    var response = await apiService.get(url: '$baseUrl/user', token: token);
    return UserModel.fromJson(response);
  }
}
