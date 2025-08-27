import 'package:flutter_movie_market/domain/entity/movie.dart';
import 'package:flutter_movie_market/presentation/widgets/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class HomeState {
  //관리해야할 변수 선언
  final List<Movie>? upcoming;
  final List<Movie>? nowPlaying;
  final List<Movie>? popular;
  final List<Movie>? topRated;
  final bool isLoading;

  HomeState({
    this.upcoming,
    this.nowPlaying,
    this.popular,
    this.topRated,
    this.isLoading = false,
  });

  HomeState copyWith({
    List<Movie>? upcoming,
    List<Movie>? nowPlaying,
    List<Movie>? popular,
    List<Movie>? topRated,
    bool? isLoading,
  }) {
    return HomeState(
        nowPlaying: nowPlaying ?? this.nowPlaying,
        popular: popular ?? this.popular,
        topRated: topRated ?? this.topRated,
        upcoming: upcoming ?? this.upcoming,
        isLoading: isLoading ?? this.isLoading);
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    // 초기 상태는 로딩 중으로 설정
    fetchMovies();
    return HomeState(isLoading: true);
  }

  // 모든 영화 데이터를 한 번에 가져오는 메소드
  Future<void> fetchMovies() async {
    try {
      // 모든 데이터를 병렬로 가져옴
      await Future.wait([
        fetchNowPlayingMovies(),
        fetchPopularMovies(),
        fetchTopRatedMovies(),
        fetchUpcomingMovies(),
      ]);
      // 로딩 완료
      state = state.copyWith(isLoading: false);
    } catch (e) {
      print('Error fetching movies: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchNowPlayingMovies() async {
    final usecase = ref.read(fetchNowPlayMoviesUseCaseProvider);
    print('usecase');
    final result = await usecase.execute();

    state = state.copyWith(nowPlaying: result);
  }

  Future<void> fetchPopularMovies() async {
    final usecase = ref.read(fetchPopularMoviesUseCaseProvider);
    final result = await usecase.execute();
    state = state.copyWith(popular: result);
  }

  Future<void> fetchTopRatedMovies() async {
    final usecase = ref.read(fetchTopRateMoviesUseCaseProvider);
    final result = await usecase.execute();
    state = state.copyWith(topRated: result);
  }

  Future<void> fetchUpcomingMovies() async {
    final usecase = ref.read(fetchUpcomingMoviesUseCaseProvider);
    final result = await usecase.execute();
    state = state.copyWith(upcoming: result);
  }
}

final homeViewModelProvider =
    NotifierProvider<HomeViewModel, HomeState>(() => HomeViewModel());
