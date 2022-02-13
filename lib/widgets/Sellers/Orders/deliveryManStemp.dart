import 'package:ecommerce/modules/generalClasses.dart';
import 'package:flutter/material.dart';

import './../../../screens/sellers/child/deliveryManProfileInSeller.dart';

class DeliveryManStemp extends StatelessWidget {
  final DeliveryMan man;
  DeliveryManStemp(this.man);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => DeliveryManProfileInSeller(man),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.height * 0.005,
          bottom: size.height * 0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: Color(0xFF305F72).withOpacity(0.23),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: man.mal
                  ? Image.asset(
                      'assets/images/male.png',
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      'assets/images/female.png',
                      fit: BoxFit.contain,
                    ),
            ),
            Text(
              man.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF305F72),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
