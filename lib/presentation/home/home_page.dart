import 'package:flutter/material.dart';
import 'package:flutter_movie_market/presentation/detail/detail_page.dart';
import 'package:flutter_movie_market/presentation/widgets/movie_poster.dart';

class MovieUI {
  final int id;
  final String title;
  final String posterUrl;
  MovieUI(this.id, this.title, this.posterUrl);
}

List<MovieUI> mock20(String seed) => List.generate(
      20,
      (i) => MovieUI(
        i + 1,
        'Movie $seed #${i + 1}',
        'https://picsum.photos/seed/${seed}_$i/500/750',
      ),
    );

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // 상단 “가장 인기있는” 배너. 패딩 20 제외 풀폭, 16:9 비율.
  Widget _featured(BuildContext context, MovieUI m) {
    final w = MediaQuery.of(context).size.width - 40; // 이유: 좌우 패딩 20씩 제외
    final h = w * 9 / 16;
    final tag = 'featured_${m.id}'; // 이유: 같은 위젯 내 tag 중복 금지
    return MoviePoster(
      heroTag: tag,
      imageUrl: m.posterUrl,
      width: w,
      height: h,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetailPage(movieId: m.id, heroTag: tag, imageUrl: m.posterUrl),
          ),
        );
      },
    );
  }

  // 공통 가로 섹션. 인기순만 rank 표시.
  Widget _section({
    required BuildContext context,
    required String title,
    required List<MovieUI> items,
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
          height: 180, // 요구사항: 각 리스트뷰 높이 180
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final m = items[index];
              final tag = '${title}_${index}_${m.id}'; // 이유: 페이지 내 고유 tag 유지
              return MoviePoster(
                heroTag: tag,
                imageUrl: m.posterUrl,
                width: 120, // 120x180 카드
                height: 180,
                rank: showRank ? index + 1 : null, // 인기순만 랭킹
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                          movieId: m.id, heroTag: tag, imageUrl: m.posterUrl),
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
  Widget build(BuildContext context) {
    final nowPlaying = mock20('now');
    final popular = mock20('pop');
    final topRated = mock20('top');
    final upcoming = mock20('upc');

    return Scaffold(
      appBar: AppBar(title: const Text('영화')),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _featured(context, popular.first), // 가장 인기있는 = 인기 1위 가정
          ),
          const SizedBox(height: 20),
          _section(context: context, title: '현재 상영중', items: nowPlaying),
          const SizedBox(height: 16),
          _section(
              context: context, title: '인기순', items: popular, showRank: true),
          const SizedBox(height: 16),
          _section(context: context, title: '평점 높은순', items: topRated),
          const SizedBox(height: 16),
          _section(context: context, title: '개봉예정', items: upcoming),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
