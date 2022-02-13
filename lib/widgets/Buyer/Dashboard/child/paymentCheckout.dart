import 'package:flutter/material.dart';

class PaymentChooseCheckOut extends StatelessWidget {
  final String choose;
  final Function func;
  PaymentChooseCheckOut(this.choose, this.func);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _everyPaymentchoose(
      String image,
      String title,
      bool select,
      Function fu,
    ) {
      return Container(
        margin: EdgeInsets.only(bottom: 10, top: 10),
        child: InkWell(
          onTap: () {
            fu();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                    height: size.width * 0.15,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF305F72),
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ],
              ),
              Icon(
                select
                    ? Icons.check_circle_outline
                    : Icons.brightness_1_outlined,
                color: select ? Colors.green : Colors.grey,
                size: 30,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: size.height * 0.12),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            color: Theme.of(context).primaryColor.withOpacity(0.23),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method :',
            style: TextStyle(
              color: Color(0xFF305F72),
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _everyPaymentchoose(
            'assets/images/mastercard.png',
            'Cradit Card / Debit Card',
            choose == 'CD' ? true : false,
            () {
              func('CD');
            },
          ),
          Divider(color: Colors.grey[700]),
          _everyPaymentchoose(
            'assets/images/googlepay.png',
            'Google Pay',
            choose == 'GP' ? true : false,
            () {
              func('GP');
            },
          ),
          Divider(color: Colors.grey[700]),
          _everyPaymentchoose(
            'assets/images/paytm.png',
            'Paytm',
            choose == 'PY' ? true : false,
            () {
              func('PY');
            },
          ),
          Divider(color: Colors.grey[700]),
          _everyPaymentchoose(
            'assets/images/phonepe.png',
            'Phone Pe',
            choose == 'PP' ? true : false,
            () {
              func('PP');
            },
          ),
        ],
      ),
    );
  }
}
