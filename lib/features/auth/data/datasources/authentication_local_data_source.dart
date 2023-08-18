
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
  Future<String?> getSessionId();
  Future<void> deleteSessionId();
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {

  final _storage =  const FlutterSecureStorage();

  @override
  Future<void> deleteSessionId() async {
    await _storage.delete(key: 'session_id');
  }

  @override
  Future<String?> getSessionId() async {
    return await _storage.read(key: 'session_id');
  }

  @override
  Future<void> saveSessionId(String sessionId) async {
    await _storage.write(key: 'session_id', value: sessionId);
  }
}
