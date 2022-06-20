import 'package:carousel_slider/carousel_slider.dart';
import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Payment.dart';
import 'package:cine_view/screens/user/addPayment_screen.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCardsScreen extends StatefulWidget {
  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  final CineService _cineService = CineService();
  List<Payment> cards = [];
  int userId = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getAll();
  }

  getAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userIdPreference = prefs.getInt('userId');
    if (userIdPreference != null) {
      await this._cineService.getCards(userIdPreference).then((value) => {
            setState(() {
              cards = value!;
            }),
            print(value)
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //reverse: true,

        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //VirtualCreditCard(cardNumber: cards[0].cardNumber.toString(), cardHolderName: cards[0].name.toString(), expiryMonth: cards[0].expirationDate.toString(), expiryYear: cards[0].expirationDate.toString(), cvv: cards[0].cvv.toString()),
            _buildCards(),
            // (cards.length > 1)
            //     ? _buildCards()
            //     : _buildCard(
            //         name: cards.first.name,
            //         cvv: cards.first.cvv.toString(),
            //         expiration: cards.first.expirationDate.toString(),
            //         number: cards.first.cardNumber.toString()),
            Divider(),
            Container(
                // top: 25,
                // left: 10,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => {
                    print('taptaptap'),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPaymentScreen()),
                    )
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20, top: 12),
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(25)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCards() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        aspectRatio: 35,
        //aspectRatio: 16/9,
        viewportFraction: 0.7,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) => {
          print(index),
          // setState(() {
          // _currentPage = index;

          // })
        },
      ),
      items: cards.map(
        (i) {
          return Builder(
            builder: (BuildContext context) {
              return _buildCard(
                  name: i.name,
                  cvv: i.cvv.toString(),
                  expiration: i.expirationDate.toString(),
                  number: i.cardNumber.toString());
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildCard({
    required String name,
    required String number,
    required String cvv,
    required String expiration,
  }) {
    return Container(
      height: 195,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      //padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xff323232), Color(0xff000000)],
        ),
      ),
      //child: cardFront(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'VISA',
                style: TextStyle(
                    fontSize: 24.30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Visa electrónica',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          Text(
            (number != '') ? number : "\t****\t\t****\t\t****\t\t****\t\t****",
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 197, 188, 188)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Titular tarjeta',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fecha caducidad',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (expiration != '') ? expiration : 'MM/AA',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
