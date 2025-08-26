import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Hero 착지 화면. 지금은 포스터만 크게. 데이터 연결 후 확장.
class DetailPage extends StatelessWidget {
  final int movieId;
  final String heroTag;
  final String imageUrl;

  const DetailPage({
    super.key,
    required this.movieId,
    required this.heroTag,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Hero(
            tag: heroTag, // 이유: Home과 동일 tag로 전환 연속성 확보
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                    height: 300,
                    color: Colors.grey.shade900,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image, size: 36)),
                errorWidget: (_, __, ___) => Container(
                    height: 300,
                    color: Colors.grey.shade800,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 36)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Movie #$movieId',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('상세 내용은 API 연결 후 채움'),
        ],
      ),
    );
  }
}
