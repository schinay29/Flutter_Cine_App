class MovieModel {
  final int movieId;
  final String name;
  final String description;
  final String date;
  final int duration;
  final String urlVideo;
  final String img;

  MovieModel({ required this.movieId, required this.name, required this.description, required this.date, required this.duration, required this.urlVideo, required this.img });
   factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieId: json['movieId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      duration: json['duration'] as int,
      urlVideo: json['urlVideo'] as String,
      img: json['img'] as String,
    );
  }
}