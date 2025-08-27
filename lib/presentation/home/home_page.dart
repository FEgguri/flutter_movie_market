import 'package:flutter/material.dart';
import 'package:flutter_movie_market/domain/entity/movie.dart';
import 'package:flutter_movie_market/presentation/detail/detail_screen.dart';
import 'package:flutter_movie_market/presentation/widgets/movie_poster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Widget _featured(BuildContext context, List<Movie>? m) {
    final w = MediaQuery.of(context).size.width - 40; //  좌우 패딩 20씩 제외
    final h = w * 9 / 16;
    if (m == null || m.isEmpty) {
      return SizedBox(
        width: w,
        height: h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final first = m.first;
    final tag = 'featured_${first.id}';
    return MoviePoster(
      heroTag: 'featured_${m.first.id}',
      imageUrl: 'https://image.tmdb.org/t/p/w500${m.first.posterPath}',
      width: w,
      height: h,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(
                movie: first, // ✅ Movie 객체 전달
                heroTag: tag,
              ),
            ));
      },
    );
  }

// 공통 가로 섹션. 인기순만 rank 표시.
  Widget _section({
    required BuildContext context,
    required String title,
    required List<Movie>? items,
    bool showRank = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180, //각 리스트뷰 높이 180
          child: items == null || items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length > 20 ? 20 : items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final m = items[index];
                    final tag = '${title}_${index}_${m.id}'; // 페이지 내 고유 tag 유지
                    return MoviePoster(
                      heroTag: tag,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${m.posterPath}',
                      width: 120, // 120x180 카드
                      height: 180,
                      rank: showRank ? index + 1 : null, // 인기순만 랭킹
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(
                              movie: m, // ✅ Movie 객체 전달
                              heroTag: tag,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('영화')),
      body:
          // state.isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _featured(context, state.popular), // 가장 인기있는 인기 1위
          ),
          const SizedBox(height: 20),
          _section(context: context, title: '현재 상영중', items: state.nowPlaying),
          const SizedBox(height: 16),
          _section(
              context: context,
              title: '인기순',
              items: state.popular,
              showRank: true),
          const SizedBox(height: 16),
          _section(context: context, title: '평점 높은순', items: state.topRated),
          const SizedBox(height: 16),
          _section(context: context, title: '개봉예정', items: state.upcoming),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
