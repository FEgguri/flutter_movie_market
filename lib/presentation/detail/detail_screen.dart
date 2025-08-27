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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
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
          Text(
            detail.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(detail.overview.isEmpty ? '개요 없음' : detail.overview),
          const SizedBox(height: 12),
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
          Column(
            children: [
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
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (detail.productionCompanyLogos ?? const <String>[])
                    .map(
                      (g) => ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: _fullUrl(g),
                          placeholder: (_, __) => Container(
                            height: 55,
                            width: 100,
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
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
