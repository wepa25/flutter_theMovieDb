import 'dart:convert';
import 'dart:io';

import 'package:the_movie/domain/entity/movie_details/movie_details.dart';
import 'package:the_movie/domain/entity/popular_movie/popular_movie_response.dart';
import 'package:the_movie/domain/entity/tv_series/tv_popular_series_response.dart';

enum ApiClientExceptionType {
  Network,
  Auth,
  Other,
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '0a2a46b5593a0978cc8e87ba34037430';
  final pathMakeToken = '/authentication/token/new';
  final pathValidateUser = '/authentication/token/validate_with_login';
  final pathSession = '/authentication/session/new';


  static String imageUrl(String path) => _imageUrl + path;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validUser = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = _makeSession(requestToken: validUser);
    return sessionId;
  }

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    try {
      final url = _makeUri(path, parameters);
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result =
        _get(pathMakeToken, parser, <String, dynamic>{'api_key': _apiKey});
    return result;
  }


  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
         'page': page.toString(),
        'language' : locale
          },
    );
    return result;
  }

  Future<TvPopularSeriesResponse> tvPopularSeries(int page, String locale) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = TvPopularSeriesResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/tv/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language' : locale,
        'page': page.toString(),
        },
     );
    return result;
  }

  Future<MovieDetails> movieDetails(int movieId, String locale) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/movie/$movieId',
      parser,
      <String, dynamic>{
        'append_to_response' : 'credits',
        'api_key': _apiKey,
        'language' : locale,
      },
    );
    return result;
  }

  Future<MovieDetails> tvSeriesDetails(int movieId, String locale) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/tv/$movieId',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language' : locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie(int page, String locale, String query) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/search/movie',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'query': query,
        'language' : locale},
    );
    return result;
  }


  Future<TvPopularSeriesResponse> searchTvSeries(int page, String locale, String query) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = TvPopularSeriesResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/search/tv',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'query': query,
        'language' : locale},
    );
    return result;
  }



  Future<T> _post<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> mapParameters, [
    Map<String, dynamic>? apiParameters,
  ]) async {
    try {
      final url = _makeUri(path, apiParameters);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(mapParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final result = _post(pathValidateUser, parser, parameters,
        <String, dynamic>{'api_key': _apiKey});
    return result;
  }

  Future<String> _makeSession({required String requestToken}) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    };
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final result = _post(
        pathSession, parser, parameters, <String, dynamic>{'api_key': _apiKey});
    return result;
  }

  void _validateResponse(
      HttpClientResponse response, Map<String, dynamic> json) {
    if (response.statusCode == 401) {
      final jsonMode = json['status_code'];
      jsonMode is int ? jsonMode : 0;
      if (jsonMode == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((value) => json.decode(value));
  }
}
