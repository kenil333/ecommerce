import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfDeliveryBoySheet extends StatelessWidget {
  final List<Deliverynamesex> del;
  final String id;
  ListOfDeliveryBoySheet(this.del, this.id);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF305F72),
            blurRadius: 25,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.5,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: del.length,
              itemBuilder: (BuildContext context, int i) => InkWell(
                onTap: () {
                  Provider.of<BackCode>(context, listen: false).assigndel(
                    id,
                    del[i].phone,
                    () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    (String error) {
                      CustomizeCode().snak(error, context);
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    top: 20,
                    left: 30,
                    right: 30,
                  ),
                  child: Row(
                    children: [
                      del[i].mal
                          ? Image.asset(
                              'assets/images/male.png',
                              height: size.height * 0.1,
                              fit: BoxFit.fitHeight,
                            )
                          : Image.asset(
                              'assets/images/female.png',
                              height: size.height * 0.1,
                              fit: BoxFit.fitHeight,
                            ),
                      SizedBox(width: 30),
                      Text(
                        del[i].name,
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          color: Color(0xFF305F72),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
