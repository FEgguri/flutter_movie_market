import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieUI {
  final int id;
  final String title;
  final String posterUrl;

  const MovieUI(this.id, this.title, this.posterUrl);
}

class HomeState {
  final List<MovieUI> featured; // 상단 1장
  final List<MovieUI> nowPlaying;
  final List<MovieUI> popular;
  final List<MovieUI> topRated;
  final List<MovieUI> upcoming;
  const HomeState({
    required this.featured,
    required this.nowPlaying,
    required this.popular,
    required this.topRated,
    required this.upcoming,
  });
}

final homeViewModelProvider =
    AsyncNotifierProvider<HomeViewModel, HomeState>(() => HomeViewModel());

class HomeViewModel extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    return _loadMock();
  }

  Future<HomeState> _loadMock() async {
    List<MovieUI> m(String seed) => List.generate(
          20,
          (i) => MovieUI(
            i + 1,
            'Movie $seed #${i + 1}',
            'https://picsum.photos/seed/${seed}_$i/500/750',
          ),
        );

    final popular = m('pop');
    return HomeState(
      featured: [popular.first],
      nowPlaying: m('now'),
      popular: popular,
      topRated: m('top'),
      upcoming: m('upc'),
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _loadMock());
  }
}
