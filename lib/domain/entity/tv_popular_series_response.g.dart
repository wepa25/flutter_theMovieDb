// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_popular_series_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvPopularSeriesResponse _$TvPopularSeriesResponseFromJson(
    Map<String, dynamic> json) {
  return TvPopularSeriesResponse(
    json['page'] as int,
    (json['results'] as List<dynamic>)
        .map((e) => TvSeries.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total_results'] as int,
    json['total_pages'] as int,
  );
}

Map<String, dynamic> _$TvPopularSeriesResponseToJson(
        TvPopularSeriesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.tvSeries.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };
