import 'package:ecommerce/modules/generalClasses.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../customizeCode.dart';
import './deliveryManStemp.dart';
import './../../../screens/sellers/child/AddDeliveryManScreen.dart';

class DeliveryManManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Users')
        .orderByChild('Who')
        .equalTo('Delivery')
        .onValue;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 10,
                ),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Man',
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 30,
                        color: Color(0xFF305F72),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => AddDeliveryManScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: api,
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: double.infinity,
                        height: size.height * 0.8,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snap.hasData &&
                          !snap.hasError &&
                          snap.data.snapshot.value != null) {
                        List<DeliveryMan> _man = [];
                        snap.data.snapshot.value.forEach(
                          (key, value) {
                            _man.add(
                              DeliveryMan(
                                phone: key,
                                name: value['Name'],
                                email: value['Email'],
                                address: value['Address'],
                                pincode: value['Pincode'],
                                mal: value['Sex'],
                              ),
                            );
                          },
                        );
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(20),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: _man.length,
                          itemBuilder: (ctx, i) {
                            return DeliveryManStemp(_man[i]);
                          },
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          height: size.height * 0.8,
                          alignment: Alignment.center,
                          child: CustomizeCode().datanot(
                            size,
                            'Please Insert Delivery Man in DataBase !',
                          ),
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
