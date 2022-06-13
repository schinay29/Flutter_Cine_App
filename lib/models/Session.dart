import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/models/Room.dart';

class Sessions {
  final Movie movie;
  final List<DetailSession> detailSessions;

  Sessions( this.movie, this.detailSessions);
   
   Sessions.fromJson(Map<String, dynamic> json) 
      : movie =  Movie.fromJson(json['movie']),
        detailSessions = (json['detailSessions'] as List).map((tagJson) => DetailSession.fromJson(tagJson)).toList();
  
}

class DetailSession {
  final int roomId;
  final Room room;
  final List<ScheduleMovie> schedules;

  DetailSession( this.roomId, this.room, this.schedules);
   
   DetailSession.fromJson(Map<String, dynamic> json) 
      : roomId = json['roomId'],
        room = Room.fromJson(json['room']),
        schedules = (json['schedules'] as List).map((tagJson) => ScheduleMovie.fromJson(tagJson)).toList();

}


class ScheduleMovie {
  final List<String> schedule;
  final String day;

  ScheduleMovie( this.schedule, this.day);
   
   ScheduleMovie.fromJson(Map<String, dynamic> json) 
      : schedule = List.from(json['schedule']),
        day  = json['day'];

}

