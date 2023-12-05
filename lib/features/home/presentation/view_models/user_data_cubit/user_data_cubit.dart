import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_to_me/core/models/user_model.dart';
import 'package:talk_to_me/features/home/data/repos/user_data_repo/user_data_repo.dart';

import '../../../../../main.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this.userDataRepo) : super(UserDataInitial());

  final UserDataRepo userDataRepo;

  UserModel? currentUser;

  Future<void> getUser() async {
    emit(GetUserDataLoading());
    try {
      currentUser = await userDataRepo.getUser(token: token!);
      emit(GetUserDataSuccess());
    } catch (e) {
      emit(GetUserDataFailure('Failed to get user data'));
    }
  }
}
