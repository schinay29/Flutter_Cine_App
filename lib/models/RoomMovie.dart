class RoomMovie {
  final String id;
  final String roomId;
  final String movieId;
  final String schedule;
  final String day;

  RoomMovie( this.id, this.roomId, this.movieId, this.schedule, this.day);
   
   RoomMovie.fromJson(Map<String, dynamic> json) 
      : id = json['id'].toString(),
        roomId = json['roomId'].toString(),
        movieId = json['movieId'].toString(),
        schedule = json['schedule'],
        day = json['day'];

  
}