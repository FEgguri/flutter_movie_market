import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_movie_market/domain/entity/movie.dart';
import 'package:flutter_movie_market/presentation/detail/detail_view_model.dart';

class DetailScreen extends ConsumerWidget {
  final Movie movie; // id, posterPath 포함
  final String heroTag; // Home과 동일 tag

  const DetailScreen({
    super.key,
    required this.movie,
    required this.heroTag,
  });

  String _fullUrl(String p) =>
      p.startsWith('http') ? p : 'https://image.tmdb.org/t/p/w300$p';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail =
        ref.watch(detailViewModelProvider(movie)); // MovieDetail? (null=로딩)
    if (detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final logos = (detail.productionCompanyLogos ?? const <String>[])
        .where((p) => p.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 포스터 + Hero
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: _fullUrl(movie.posterPath),
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  height: 300,
                  color: Colors.grey.shade900,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, size: 36),
                ),
                errorWidget: (_, __, ___) => Container(
                  height: 300,
                  color: Colors.grey.shade800,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 36),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 제목, 개요
          Text(detail.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(detail.overview.isEmpty ? '개요 없음' : detail.overview),

          const SizedBox(height: 12),

          // 장르 칩
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (detail.genres ?? const <String>[])
                .map((g) => Chip(
                      label: Text(g),
                      backgroundColor: Colors.grey.shade900,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                    ))
                .toList(),
          ),

          const SizedBox(height: 12),

          // 러닝타임/평점
          Row(
            children: [
              const Icon(Icons.timer, size: 18),
              const SizedBox(width: 6),
              Text('${detail.runtime}분'),
              const SizedBox(width: 16),
              const Icon(Icons.star, size: 18),
              const SizedBox(width: 6),
              Text(
                  '${detail.voteAverage.toStringAsFixed(1)} (${detail.voteCount})'),
            ],
          ),

          const SizedBox(height: 16),

          // 제작사 로고 가로 리스트뷰
          if (logos.isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                itemCount: logos.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) {
                  final path = logos[i];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: _fullUrl(path),
                      width: 100,
                      height: 60,
                      fit: BoxFit.contain,
                      placeholder: (_, __) => Container(
                        width: 100,
                        height: 60,
                        color: Colors.grey.shade900,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image, size: 24),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: 100,
                        height: 60,
                        color: Colors.grey.shade800,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image, size: 24),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
