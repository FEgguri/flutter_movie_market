import 'package:flutter_movie_market/domain/entity/movie_detail.dart';
import 'package:flutter_movie_market/domain/repository/movie_repository.dart';

class FetchMovieDetailUsecase {
  final MovieRepository movieRepository;
  FetchMovieDetailUsecase(this.movieRepository);

  Future<MovieDetail?> execute(int id) async {
    return await movieRepository.fetchMovieDetail(id);
  }
}
