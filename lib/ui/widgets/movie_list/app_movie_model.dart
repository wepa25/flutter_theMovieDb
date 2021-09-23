import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/domain/entity/popular_movie/movie.dart';
import 'package:the_movie/domain/entity/popular_movie/popular_movie_response.dart';
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
  String? _searchQuery;
  Timer? seacrhDebounce;

  Future<void> setupLocale(BuildContext context) async{
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetMovies();
  }

  Future<void> _resetMovies() async{
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
   await _loadNextPage();
  }

  String stringDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';

  Future<PopularMovieResponse> _loadMovies(int nextPage, String locale)async{
    final query = _searchQuery;
    if(query == null){
     return await _apiClient.popularMovie(nextPage, _locale);
    }else{
     return   await _apiClient.searchMovie(nextPage, _locale, query);
    }
  }

  Future<void> _loadNextPage() async {
    if(_isLoadInProgress || _currentPage >= _totalPage) return;
    _isLoadInProgress = true;
    final nextPage = _currentPage + 1;
    try{
      final movieResponse = await _loadMovies(nextPage, _locale);
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
    if(index < _movies.length - 1) return;
    _loadNextPage();
  }

  Future<void> searchMovie(String text) async{
    seacrhDebounce?.cancel();
    seacrhDebounce = Timer.periodic(Duration(milliseconds: 250), (timer) async {
      final searchQuery = text.isNotEmpty ? text : null;
      if(_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      await _resetMovies();
    });
  }
}