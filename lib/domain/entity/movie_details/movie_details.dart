import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie/domain/entity/movie_date_parser.dart';
import 'package:the_movie/domain/entity/movie_details/movie_details_credits.dart';
part 'movie_details.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class MovieDetails{
  final bool adult;
  final String?  backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final num popularity;
  final String? posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  @JsonKey(fromJson: movieDateParser)
  final DateTime? releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final num voteAverage;
  final int voteCount;
  final MovieDetailsCredits credits;

  MovieDetails(this.adult, this.backdropPath, this.belongsToCollection,
      this.budget, this.genres, this.homepage, this.id, this.imdbId,
      this.originalLanguage, this.originalTitle, this.overview, this.popularity,
      this.posterPath, this.productionCompanies, this.productionCountries,
      this.releaseDate, this.revenue, this.runtime, this.spokenLanguages,
      this.status, this.tagline, this.title, this.video, this.voteAverage,
      this.voteCount, this.credits);

  factory MovieDetails.fromJson(Map<String, dynamic> json) => _$MovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}

@JsonSerializable()
class BelongsToCollection{
  const BelongsToCollection();

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => _$BelongsToCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genres{
  final int id;
  final String name;
  Genres(this.id, this.name);
  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanies{
  final String name;
  final int id;
  final String? logoPath;
  final String originCountry;

  ProductionCompanies(this.name, this.id, this.logoPath, this.originCountry);
  factory ProductionCompanies.fromJson(Map<String, dynamic> json) => _$ProductionCompaniesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountries{
  @JsonKey(name:'iso_3166_1')
  final String iso;
  final String name;

  ProductionCountries(this.iso, this.name);

  factory ProductionCountries.fromJson(Map<String, dynamic> json) => _$ProductionCountriesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguages {
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;

  SpokenLanguages(this.iso, this.name);

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) => _$SpokenLanguagesFromJson(json);
  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);
}