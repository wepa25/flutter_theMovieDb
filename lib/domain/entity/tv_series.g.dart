// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvSeries _$TvSeriesFromJson(Map<String, dynamic> json) {
  return TvSeries(
    json['poster_path'] as String?,
    json['popularity'] as double,
    json['id'] as int,
    json['backdrop_path'] as String?,
    json['vote_average'] as num,
    json['overview'] as String,
    TvSeries._parseDate(json['first_air_date'] as String?),
    (json['origin_country'] as List<dynamic>).map((e) => e as String).toList(),
    (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
    json['original_language'] as String,
    json['vote_count'] as int,
    json['name'] as String,
    json['original_name'] as String,
  );
}

Map<String, dynamic> _$TvSeriesToJson(TvSeries instance) => <String, dynamic>{
      'poster_path': instance.posterPath,
      'popularity': instance.popularity,
      'id': instance.id,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
      'overview': instance.overview,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'origin_country': instance.originCountry,
      'genre_ids': instance.genreIds,
      'original_language': instance.originalLanguage,
      'vote_count': instance.voteCount,
      'name': instance.name,
      'original_name': instance.originalName,
    };
