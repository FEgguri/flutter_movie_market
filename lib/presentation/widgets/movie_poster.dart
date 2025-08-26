import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 공용 포스터 카드.
/// - Hero 전환용 tag 필요(두 페이지 동일 tag)
/// - 인기순 섹션만 rank 뱃지 사용
class MoviePoster extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final double width;
  final double height;
  final int? rank; // null이면 미표시
  final VoidCallback onTap;

  const MoviePoster({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.onTap,
    this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag, //페이지 전환 시 같은 tag끼리 애니메이션
      child: Material(
        color: Colors.transparent, //  자연스럽게
        child: InkWell(
          onTap: onTap, //탭 시 상세로 이동
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    width: width,
                    height: height,
                    color: Colors.grey.shade900, //다크 테마에 맞춘 플레이스홀더
                    alignment: Alignment.center,
                    child: const Icon(Icons.image, size: 36),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    width: width,
                    height: height,
                    color: Colors.grey.shade800,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 36),
                  ),
                ),
              ),
              if (rank != null)
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6), //수정예정
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$rank',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
