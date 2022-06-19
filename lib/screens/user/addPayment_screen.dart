import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/Payment.dart';
import 'package:cine_view/screens/user/myCards_screen.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddPaymentScreen extends StatefulWidget {
  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final CineService _cineService = CineService();
  var cardNumberMask = MaskTextInputFormatter(
      mask: '####  ####  ####  ####', filter: {"#": RegExp(r'[0-9]')});
  var cardDateMask =
      MaskTextInputFormatter(mask: '##-##', filter: {"#": RegExp(r'[0-9]')});
  var cardCvvMask =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  final cardName = TextEditingController();
  final cardNumber = TextEditingController();
  final cardCvv = TextEditingController();
  final cardExpiration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Mis Tarjetas',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            _buildCard(),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),

            _buildTextField(
                paddingLeft: 15,
                paddingRight: 15,
                hintText: 'Propietario de la tarjeta',
                inputType: TextInputType.name,
                controller: cardName,
                mask: MaskTextInputFormatter()),
            _buildTextField(
                paddingLeft: 15,
                paddingRight: 15,
                hintText: 'Número de la tarjeta',
                inputType: TextInputType.number,
                controller: cardNumber,
                mask: cardNumberMask),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                      paddingLeft: 15,
                      paddingRight: 10,
                      hintText: 'Fecha caducidad',
                      inputType: TextInputType.datetime,
                      controller: cardExpiration,
                      mask: cardDateMask),
                ),
                Expanded(
                  child: _buildTextField(
                      paddingLeft: 10,
                      paddingRight: 15,
                      hintText: 'CVV',
                      inputType: TextInputType.number,
                      controller: cardCvv,
                      mask: cardCvvMask),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 35,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.blue,
                      onPressed: () {
                        var currentUser = 1;
                        var valuesDate = cardExpiration.text.split('-');
                        var date =
                            '20' + valuesDate[1] + '-' + valuesDate[0] + '-01';
                        var number = cardNumber.text.replaceAll('  ', '');
                        print('testtttt:' + cardExpiration.text);
                        print(date);
                        saveCard(Payment(
                            cardName.text,
                            int.parse(number),
                            int.parse(cardCvv.text),
                            currentUser,
                            DateTime.parse(date)));
                        print('card payment object: ' + cardName.text);
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(builder: (context) => BuyTicketsScreen()),
                        //   (Route<dynamic> route) => false);
                        //Navigator.pushNamed(context, '/second');
                      },
                      child: Text(
                        "Añadir método de pago".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 35,
                )
              ],
            ),
            //Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
          ],
        ),
      ),
    );
  }

  saveCard(Payment payment) async {
    print('Add Payment');
    print(payment.cardNumber);
    print(payment.cvv);
    print(payment.expirationDate);
    print(payment.name);
    print(payment.userId);
    await _cineService.saveCard(payment);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyCardsScreen()));
  }

  Widget _buildCard() {
    return Container(
      height: 195,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xff323232), Color(0xff000000)],
        ),
      ),
      child: cardFront(),
      // child: Transform(
      //   transform: Matrix4.identity()
      //   ..setEntry(3,2,0.001)
      //   ..rotateY(pi/ 180 * 360),

      //   child: cardFront(),
      // ),
    );
  }

  Widget cardFront() {
    return Column(
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
          (cardNumber.text != '')
              ? cardNumber.text
              : "\t****\t\t****\t\t****\t\t****\t\t****",
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
                        cardName.text,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
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
                        (cardExpiration.text != '')
                            ? cardExpiration.text
                            : 'MM/AA',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      {required double paddingLeft,
      required double paddingRight,
      required String hintText,
      required TextInputType inputType,
      required TextEditingController controller,
      required MaskTextInputFormatter mask}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        top: 20,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: TextField(
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey.shade500),
            fillColor: Colors.grey.shade100,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none)),
        keyboardType: inputType,
        inputFormatters: [mask],
        controller: controller,
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
