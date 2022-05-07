class Movie {
  final int movieId;
  final String name;
  final String description;
  final String date;
  final int duration;
  final String urlVideo;
  final String img;

  Movie( this.movieId, this.name, this.description, this.date, this.duration, this.urlVideo, this.img );
   
   Movie.fromJson(Map<String, dynamic> json) 
      : movieId = json['movieId'],
        name = json['name'],
        description = json['description'],
        date = json['date'],
        duration = json['duration'],
        urlVideo = json['urlVideo'],
        img = json['img'];
    
  
}