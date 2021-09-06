

class Movie{
  final String? posterPath;
  final bool adult;
  final String overview;
  final DateTime? releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int vote_count;
  final bool video;
  final double voteAverage;

  Movie(
      this.posterPath,
      this.adult,
      this.overview,
      this.releaseDate,
      this.genreIds,
      this.id,
      this.originalTitle,
      this.originalLanguage,
      this.title,
      this.backdropPath,
      this.popularity,
      this.vote_count,
      this.video,
      this.voteAverage);
}



