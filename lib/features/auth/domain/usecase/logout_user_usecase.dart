import '../repository/auth_repository.dart';

class LogoutUserUseCase {
  final AuthRepository repository;

  LogoutUserUseCase({required this.repository});

  Future<void> call() {
    return repository.logoutUser();
  }
}
