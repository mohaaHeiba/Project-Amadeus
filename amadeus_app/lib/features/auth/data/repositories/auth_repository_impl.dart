import 'package:amadeus_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:amadeus_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveOperatorName(String name) async {
    try {
      await localDataSource.cacheOperatorData(name);
    } catch (e) {
      throw Exception('Failed to save operator data');
    }
  }
}
