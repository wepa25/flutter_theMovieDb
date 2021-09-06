import 'package:the_movie/domain/session_data_provider/session_data_provider.dart';

class MyAppModel{
  final sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> chekAuth() async{
    final session = await sessionDataProvider.getSessionId();
    _isAuth = session != null;
  }
}