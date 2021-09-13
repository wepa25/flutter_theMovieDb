import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/domain/entity/movie.dart';
import 'package:the_movie/ui/navigation/main_navigation.dart';

class MoviesListModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  late DateFormat _dateFormat;
  late String _locale = '';
  late int _currentPage;
  late int _totalPage;
  var _isLoadInProgress = false;


  void setupLocale(BuildContext context){
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    _loadMovies();
    print('my locale is: $locale');
  }

  String stringDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';

  Future<void> _loadMovies() async {
    if(_isLoadInProgress || _currentPage >= _totalPage) return;
    _isLoadInProgress = true;
    final nextPage = _currentPage + 1;
    try{
      final movieResponse = await _apiClient.popularMovie(nextPage, _locale);
      _movies.addAll(movieResponse.movies);
      _currentPage = movieResponse.page;
      _totalPage = movieResponse.totalPages;
      _isLoadInProgress = false;
      notifyListeners();
    }catch(e){
      _isLoadInProgress = false;
    }
  }

  void onMovieTap(BuildContext context, int index){
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(MainNavigationRouteNames.movieDetails,arguments: id);
  }

  void showedMoviesIndex(int index) {
    if(index < movies.length - 1) return;
    _loadMovies();
  }
}