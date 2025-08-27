import 'package:flutter_movie_market/domain/entity/movie.dart';
import 'package:flutter_movie_market/presentation/widgets/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class HomeState {
  //관리해야할 변수 선언
  final List<Movie>? upcoming;
  final List<Movie>? nowPlaying;
  final List<Movie>? popular;
  final List<Movie>? topRated;

  HomeState({
    this.upcoming,
    this.nowPlaying,
    this.popular,
    this.topRated,
  });

  HomeState copyWith({
    List<Movie>? upcoming,
    List<Movie>? nowPlaying,
    List<Movie>? popular,
    List<Movie>? topRated,
  }) {
    return HomeState(
        nowPlaying: nowPlaying ?? this.nowPlaying,
        popular: popular ?? this.popular,
        topRated: topRated ?? this.topRated,
        upcoming: upcoming ?? this.upcoming);
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    fetchNowPlayingMovies();
    fetchPopularMovies();
    fetchTopRatedMovies();
    fetchUpcomingMovies();
    return HomeState();
  }

  Future<void> fetchNowPlayingMovies() async {
    final usecase = ref.read(fetchNowPlayMoviesUseCaseProvider);
    print(usecase.excute());
    final result = await usecase.excute();
    print('build2');
    state = state.copyWith(nowPlaying: result);
  }

  Future<void> fetchPopularMovies() async {
    final usecase = ref.read(fetchPopularMoviesUseCaseProvider);
    final result = await usecase.excute();

    state = state.copyWith(popular: result);
  }

  Future<void> fetchTopRatedMovies() async {
    final usecase = ref.read(fetchTopRateMoviesUseCaseProvider);
    final result = await usecase.excute();

    state = state.copyWith(topRated: result);
  }

  Future<void> fetchUpcomingMovies() async {
    final usecase = ref.read(fetchUpcomingMoviesUseCaseProvider);
    final result = await usecase.excute();

    state = state.copyWith(upcoming: result);
  }
}

final homeViewModelProvider =
    NotifierProvider<HomeViewModel, HomeState>(() => HomeViewModel());
