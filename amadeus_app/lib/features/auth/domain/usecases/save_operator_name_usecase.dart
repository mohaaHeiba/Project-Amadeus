import 'package:amadeus_app/features/auth/domain/repositories/auth_repository.dart';

class SaveOperatorNameUsecase {
  final AuthRepository repository;

  SaveOperatorNameUsecase(this.repository);

  Future<void> call(String name) async {
    return repository.saveOperatorName(name);
  }
}
