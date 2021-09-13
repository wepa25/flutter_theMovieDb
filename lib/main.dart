import 'package:flutter/material.dart';
import 'package:the_movie/ui/widgets/app/my_app.dart';
import 'package:the_movie/ui/widgets/app/my_app_model.dart';
import 'package:flutter/services.dart';

void main()async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarDividerColor: Colors.white,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final _model = MyAppModel();
  await _model.chekAuth();
  Widget app = MyApp(model: _model);
  runApp(app);
}

