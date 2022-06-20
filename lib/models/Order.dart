
class Order {
  final int id;
  final int quantity;
  final double price;
  final DateTime createdDate;
  final int userId;

  Order( this.id, this.quantity, this.price, this.createdDate, this.userId);
   
   Order.fromJson(Map<String, dynamic> json) 
      : id = json['id'],
        quantity = json['quantity'],
        price = json['price'],
        createdDate = DateTime.parse(json['createdDate']),
        userId = json['userId'];
        
    
  
}