import 'package:flutter_movie_market/domain/entity/movie.dart';
import 'package:flutter_movie_market/domain/entity/movie_detail.dart';
import 'package:flutter_movie_market/presentation/widgets/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailViewModel extends AutoDisposeFamilyNotifier<MovieDetail?, Movie> {
  @override
  MovieDetail? build(Movie arg) {
    fetchMovieDetail();
    return null;
  }

  Future<void> fetchMovieDetail() async {
    final fetchMovieDetailUsecase = ref.read(fetchMovieDetailUseCaseProvider);
    final result = await fetchMovieDetailUsecase.execute(arg.id);
    state = result;
  }
}

final detailViewModelProvider =
    NotifierProvider.autoDispose.family<DetailViewModel, MovieDetail?, Movie>(
  () => DetailViewModel(),
);
