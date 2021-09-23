import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie/domain/entity/tv_series/tv_series.dart';

part 'tv_popular_series_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvPopularSeriesResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<TvSeries> tvSeries;
  final int totalResults;
  final int totalPages;

  TvPopularSeriesResponse(this.page,
      this.tvSeries,
      this.totalResults,
      this.totalPages,);

  factory TvPopularSeriesResponse.fromJson(Map<String, dynamic> json) => _$TvPopularSeriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TvPopularSeriesResponseToJson(this);
}