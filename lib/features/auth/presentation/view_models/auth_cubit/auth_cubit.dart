import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_to_me/features/auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> register(
      {required String username,
      required String email,
      required String password}) async {
    emit(AuthLoading());
    try {
      await authRepo.register(
          username: username, email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await authRepo.login(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }
}
