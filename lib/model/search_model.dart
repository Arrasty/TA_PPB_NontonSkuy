import 'package:nontonskuy/model/movie/movie_model.dart';

class MovieSearchModel {
  final List<Movie> results;

  MovieSearchModel({required this.results});

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) {
    return MovieSearchModel(
      results: List<Movie>.from(
        json['results'].map((result) => Movie.fromJson(result)),
      ).where((movie) => movie.id != null && movie.title != null).toList(),
    );
  }
}
