import 'package:flutter_movie_market/data/datasource/movie_data_source.dart';
import 'package:flutter_movie_market/data/datasource/movie_data_source_impl.dart';
import 'package:flutter_movie_market/data/repository/movie_repository_impl.dart';
import 'package:flutter_movie_market/domain/repository/movie_repository.dart';
import 'package:flutter_movie_market/domain/usecase/fetch_movie_detail_usecase.dart';
import 'package:flutter_movie_market/domain/usecase/fetch_now_playing_movies_usecase.dart';
import 'package:flutter_movie_market/domain/usecase/fetch_popular_movies_usecase.dart';
import 'package:flutter_movie_market/domain/usecase/fetch_top_rated_movies_usercase.dart';
import 'package:flutter_movie_market/domain/usecase/fetch_upcoming_movies_usecase.dart';
import 'package:flutter_movie_market/presentation/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _moviedatasourceProvider = Provider<MovieDataSource>((ref) {
  return MovieDataSourceImpl();
});

final _movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dataSource = ref.read(_moviedatasourceProvider);
  return MovieRepositoryImpl(dataSource);
});

final _fetchMovieDetailUseCaseProvider = Provider(
  (ref) {
    final movieRepository = ref.read(_movieRepositoryProvider);
    return FetchMovieDetailUsecase(movieRepository);
  },
);

final fetchNowPlayMoviesUseCaseProvider = Provider(
  (ref) {
    final movieRepository = ref.read(_movieRepositoryProvider);
    return FetchNowPlayingMoviesUsecase(movieRepository);
  },
);

final fetchPopularMoviesUseCaseProvider = Provider(
  (ref) {
    final movieRepository = ref.read(_movieRepositoryProvider);
    return FetchPopularMoviesUsecase(movieRepository);
  },
);

final fetchTopRateMoviesUseCaseProvider = Provider(
  (ref) {
    final movieRepository = ref.read(_movieRepositoryProvider);
    return FetchTopRatedMoviesUsecase(movieRepository);
  },
);

final fetchUpcomingMoviesUseCaseProvider = Provider(
  (ref) {
    final movieRepository = ref.read(_movieRepositoryProvider);
    return FetchUpcomingMoviesUsecase(movieRepository);
  },
);

// --- Presentation Layer (ViewModels) ---
// final homeViewModelProvider =
//     StateNotifierProvider<HomeViewModel, HomeState>((ref) {
//   return HomeViewModel(
//     fetchPopularMoviesUsecase: ref.read(fetchPopularMoviesUseCaseProvider),
//     fetchNowPlayingMoviesUsecase: ref.read(fetchNowPlayMoviesUseCaseProvider),
//     fetchTopRatedMoviesUsecase: ref.read(fetchTopRateMoviesUseCaseProvider),
//     fetchUpcomingMoviesUsecase: ref.read(fetchUpcomingMoviesUseCaseProvider),
//   );
// });

// final detailViewModelProvider =
//     StateNotifierProvider.family<DetailViewModel, DetailState, int>(
//         (ref, movieId) {
//   return DetailViewModel(
//     movieId: movieId,
//     fetchMovieDetailUsecase: ref.read(_fetchMovieDetailUsecaseProvider),
//   );
// });
