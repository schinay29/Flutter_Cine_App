import 'dart:convert';

class Payment {
  final String name;
  final int cardNumber;
  final int cvv;
  final int userId;
  final DateTime expirationDate;

  Payment(this.name, this.cardNumber, this.cvv, this.userId, this.expirationDate);
   
   Payment.fromJson(Map<String, dynamic> json) 
      : name = json['name'],
        cardNumber = json['cardNumber'],
        cvv = json['cvv'],
        userId = json['userId'],
        expirationDate = json['expiration'];
         
}