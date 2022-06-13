class Room {
  final int roomId;
  final int number;
  final int row;
  final int col;
  final int cinemaId;

  Room( this.roomId, this.number, this.row, this.col, this.cinemaId);
   
   Room.fromJson(Map<String, dynamic> json) 
      : roomId = json['id'],
        number = json['number'],
        row = json['row'],
        col = json['col'],
        cinemaId = json['cinemaId'];

  
}