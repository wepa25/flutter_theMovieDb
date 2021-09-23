import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/domain/entity/movie_details/movie_details.dart';

class MovieDetailModel extends ChangeNotifier{
  final _apiClient = ApiClient();

  final int movieId;

  MovieDetails? _movieDetails;
  MovieDetails? get movieDetails => _movieDetails;

  late String _locale = '';
  late DateFormat _dateFormat;

  MovieDetailModel(this.movieId,);

  String stringDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async{
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadMovieDetail();
  }

  Future<void> loadMovieDetail() async {
  _movieDetails = await _apiClient.movieDetails(movieId, _locale);
  notifyListeners();
  }


}