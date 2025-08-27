import 'package:flutter_movie_market/data/datasource/movie_data_source.dart';
import 'package:flutter_movie_market/domain/entity/movie.dart';
import 'package:flutter_movie_market/domain/entity/movie_detail.dart';
import 'package:flutter_movie_market/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource movieDataSource;

  MovieRepositoryImpl(this.movieDataSource);

  @override
  Future<MovieDetail?> fetchMovieDetail(int id) async {
    final source = await movieDataSource.fetchMovieDetail(id);
    if (source == null) return null;
    final genres = source.genres;
    final logos = source.productionCompanies;

    return MovieDetail(
      budget: source.budget ?? 1,
      genres:
          // null,
          genres == null
              ? []
              : List.from(
                  genres.map((e) => e.name),
                ),
      id: source.id,
      productionCompanyLogos:
          // null,
          logos == null
              ? []
              : List.from(
                  logos.map(
                    (e) => e.logoPath ?? '',
                  ),
                ),
      overview: source.overview,
      popularity: source.popularity,
      releaseDate: source.releaseDate,
      revenue: source.revenue,
      runtime: source.runtime,
      tagline: source.tagline,
      title: source.title,
      voteAverage: source.voteAverage,
      voteCount: source.voteCount,
    );
  }

  @override
  Future<List<Movie>?> fetchNowPlayingMovies() async {
    final source = await movieDataSource.fetchNowPlayingMovies();
    if (source == null) return null;

    return List<Movie>.from(
      source.results.map(
        (e) {
          return Movie(
            id: e.id,
            posterPath: e.posterPath,
          );
        },
      ),
    );
  }

  @override
  Future<List<Movie>?> fetchPopularMovies() async {
    final source = await movieDataSource.fetchPopularMovies();
    if (source == null) return null;

    return List<Movie>.from(
      source.results.map(
        (e) {
          return Movie(
            id: e.id,
            posterPath: e.posterPath,
          );
        },
      ),
    );
  }

  @override
  Future<List<Movie>?> fetchTopRatedMovies() async {
    final source = await movieDataSource.fetchTopRatedMovies();
    if (source == null) return null;

    return List<Movie>.from(
      source.results.map(
        (e) {
          return Movie(
            id: e.id,
            posterPath: e.posterPath,
          );
        },
      ),
    );
  }

  @override
  Future<List<Movie>?> fetchUpcomingMovies() async {
    final source = await movieDataSource.fetchUpcomingMovies();
    if (source == null) return null;

    return List<Movie>.from(
      source.results.map(
        (e) {
          return Movie(
            id: e.id,
            posterPath: e.posterPath,
          );
        },
      ),
    );
  }
}
