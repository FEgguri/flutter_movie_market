import 'package:flutter_movie_market/domain/entity/movie.dart';
import 'package:flutter_movie_market/domain/repository/movie_repository.dart';

class FetchTopRatedMoviesUsecase {
  final MovieRepository movieRepository;
  FetchTopRatedMoviesUsecase(this.movieRepository);

  Future<List<Movie>?> excute() async {
    return await movieRepository.fetchTopRatedMovies();
  }
}
