import 'dart:convert';

import 'package:flutter_movie_market/data/datasource/movie_data_source.dart';
import 'package:flutter_movie_market/data/dto/movie_detail_dto.dart';
import 'package:flutter_movie_market/data/dto/movie_response_dto.dart';
import 'package:flutter_movie_market/dio_client.dart';

//데이터소스 -> DTO
class MovieDataSourceImpl implements MovieDataSource {
  @override
  Future<MovieDetailDto?> fetchMovieDetail(int id) async {
    //api요청
    //Endpoint,queryParameters
    final response = await DioClient.client
        .get('${id}', queryParameters: {'language': 'ko-KR'});

    final json = jsonDecode(response.toString());

    return MovieDetailDto.fromJson(json);
  }

  @override
  Future<MovieResponseDto?> fetchNowPlayingMovies() async {
    final response = await DioClient.client
        .get('now_playing', queryParameters: {'language': 'ko-KR'});

    final json = jsonDecode(response.toString());

    return MovieResponseDto.fromJson(json);
  }

  @override
  Future<MovieResponseDto?> fetchPopularMovies() async {
    final response = await DioClient.client
        .get('popular', queryParameters: {'language': 'ko-KR'});

    final json = jsonDecode(response.toString());

    return MovieResponseDto.fromJson(json);
  }

  @override
  Future<MovieResponseDto?> fetchTopRatedMovies() async {
    final response = await DioClient.client
        .get('top_rated', queryParameters: {'language': 'ko-KR'});

    final json = jsonDecode(response.toString());

    return MovieResponseDto.fromJson(json);
  }

  @override
  Future<MovieResponseDto?> fetchUpcomingMovies() async {
    final response = await DioClient.client
        .get('upcoming', queryParameters: {'language': 'ko-KR'});

    final json = jsonDecode(response.toString());

    return MovieResponseDto.fromJson(json);
  }
}
