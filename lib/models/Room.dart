class Room {
  final String roomId;
  final String number;
  final String row;
  final String col;
  final String cinemaId;

  Room( this.roomId, this.number, this.row, this.col, this.cinemaId);
   
   Room.fromJson(Map<String, dynamic> json) 
      : roomId = json['id'].toString(),
        number = json['number'].toString(),
        row = json['row'].toString(),
        col = json['col'].toString(),
        cinemaId = json['cinemaId'].toString();

  
}