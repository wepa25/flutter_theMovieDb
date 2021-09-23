import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/domain/entity/tv_series/tv_popular_series_response.dart';
import 'package:the_movie/domain/entity/tv_series/tv_series.dart';
import 'package:the_movie/ui/navigation/main_navigation.dart';

class TvSeriesListWidgetModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;
  final List<TvSeries> serchedList = [];
  late DateFormat _dateFormat;
  late String _locale = '';
  late int _currentPage;
  late int _totalPage;
  var _isLoadInProgress = false;
  String? _searchQuery;
  Timer? searchDebounce;


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
    _tvSeries.clear();
    await _loadNextPage();
  }

  String stringDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';


  Future<TvPopularSeriesResponse> _loadTvSeries(int nextPage, String locale)async{
    final query = _searchQuery;
    if(query == null){
      return await _apiClient.tvPopularSeries(nextPage, _locale);
    }else{
      return   await _apiClient.searchTvSeries(nextPage, _locale, query);
    }
  }


  Future<void> _loadNextPage() async {
    if(_isLoadInProgress || _currentPage >= _totalPage) return;
    _isLoadInProgress = true;
    final nextPage = _currentPage + 1;
     try{
      final tvSeriesResponse = await _loadTvSeries(nextPage, _locale);
      _tvSeries.addAll(tvSeriesResponse.tvSeries);
      _currentPage = tvSeriesResponse.page;
      _totalPage = tvSeriesResponse.totalPages;
      _isLoadInProgress = false;
      notifyListeners();
    }catch(e){
      _isLoadInProgress = false;
    }
}


  void onMovieTap(BuildContext context, int index){
    final id = _tvSeries[index].id;
    Navigator.of(context).pushNamed(MainNavigationRouteNames.movieDetails,arguments: id);
  }

  void showedMoviesIndex(int index) {
    if(index < _tvSeries.length - 1) return;
    _loadNextPage();
  }

  Future<void> searchMovie(String text) async{
    searchDebounce?.cancel();
    searchDebounce = Timer.periodic(Duration(milliseconds: 250), (timer) async {
      final searchQuery = text.isNotEmpty ? text : null;
      if(_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      _currentPage = 0;
      _totalPage = 1;
      _tvSeries.clear();
      if(_isLoadInProgress || _currentPage >= _totalPage) return;
      _isLoadInProgress = true;
      final nextPage = _currentPage + 1;
      try{
        final tvSeriesResponse = await _loadTvSeries(nextPage, _locale);
        _tvSeries.addAll(tvSeriesResponse.tvSeries);
        _currentPage = tvSeriesResponse.page;
        _totalPage = tvSeriesResponse.totalPages;
        _isLoadInProgress = false;
        notifyListeners();
      }catch(e){
        _isLoadInProgress = false;
      }
      // await _resetMovies();
    });
  }
}

