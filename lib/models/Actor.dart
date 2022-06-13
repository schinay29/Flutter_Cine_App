
class Actor {
  final int id;
  final String name;
  final String url;

  Actor( this.id, this.name, this.url );
   
   Actor.fromJson(Map<String, dynamic> json) 
      : id = json['id'],
        name = json['name'],
        url = json['url'];
  
}