import 'package:amadeus_app/core/services/cache_helper.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheOperatorData(String name);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final CacheHelper cacheHelper;

  AuthLocalDataSourceImpl({required this.cacheHelper});
  @override
  Future<void> cacheOperatorData(String name) async {
    await cacheHelper.saveOperatorName(name);
    await cacheHelper.setLoggedIn();
  }
}
