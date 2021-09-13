import 'package:flutter/material.dart';
import 'package:the_movie/library/inherited/provider.dart';
import 'package:the_movie/ui/widgets/auth/auth_model.dart';
import 'package:the_movie/ui/widgets/auth/auth_widget.dart';
import 'package:the_movie/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:the_movie/ui/widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_detail';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) =>
        NotifierProvider(model: AuthModel(), child: AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => MainScreenWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (context) => MovieDetailsWidget(
                  id: movieId,
                ),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (context)=> widget);
    }
  }
}
