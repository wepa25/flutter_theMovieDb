import 'package:flutter/material.dart';
import 'package:the_movie/styles/styles_of_app_widget.dart';
import 'package:the_movie/ui/navigation/main_navigation.dart';
import 'package:the_movie/ui/widgets/app/my_app_model.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
        AppBarTheme(backgroundColor: StylesOFAppWidget.colorOfAppBar),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: StylesOFAppWidget.colorOfAppBar,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey),
        primarySwatch: Colors.blue,
      ),
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
    );

  }
}
