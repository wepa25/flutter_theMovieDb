import 'package:flutter/material.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/domain/session_data_provider/session_data_provider.dart';
import 'package:the_movie/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();

  bool _isAuthProgress = false;

  bool get canStartAuth => !_isAuthProgress;

  bool get isAuthProgress => _isAuthProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async {
    final login = controllerLogin.text;
    final password = controllerPassword.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
    } on ApiClientException catch(e) {
      switch (e.type){
        case ApiClientExceptionType.Network :
          _errorMessage = 'Сервер недоступен. Проверьте интернет!';
          break;
         case ApiClientExceptionType.Auth:
          _errorMessage = 'Неправильный логин или пароль!';
          break;
        case ApiClientExceptionType.Other:
          _errorMessage = 'Произошла ошибка. Попробуйте еще раз!';
          break;
    }
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'Неизвесная ошибка, повторите попытку!';
      notifyListeners();
      return;
    }
    await sessionDataProvider.setSessionId(sessionId);
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }
}
