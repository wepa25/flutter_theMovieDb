import 'package:json_annotation/json_annotation.dart';

part 'tv_series.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake,)
class TvSeries{
  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final num voteAverage;
  final String overview;
  @JsonKey(fromJson: _parseDate)
  final DateTime? firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;



  TvSeries(
      this.posterPath,
      this.popularity,
      this.id,
      this.backdropPath,
      this.voteAverage,
      this.overview,
      this.firstAirDate,
      this.originCountry,
      this.genreIds,
      this.originalLanguage,
      this.voteCount,
      this.name,
      this.originalName);

  static DateTime? _parseDate(String? firstAirDate){
    if(firstAirDate == null || firstAirDate.isEmpty) return null;
    return DateTime.tryParse(firstAirDate);
  }

  factory TvSeries.fromJson(Map<String, dynamic> json) => _$TvSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$TvSeriesToJson(this);
}