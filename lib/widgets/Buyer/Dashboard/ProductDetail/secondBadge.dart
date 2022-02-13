import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondBadgeOfProductDetail extends StatelessWidget {
  final Products prod;
  SecondBadgeOfProductDetail(this.prod);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String _phone =
        Provider.of<BackCode>(context, listen: false).me.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Like')
        .child(_phone)
        .child(prod.id)
        .onValue;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: size.height * 0.1,
            ),
            padding: EdgeInsets.only(
              top: size.height * 0.3,
              left: 35,
              right: 35,
              bottom: 35,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0xFF305F72).withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    prod.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      color: Color(0xFF305F72),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2942),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '₹ ${prod.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Color(0xFFFFC344),
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.35,
            padding: EdgeInsets.symmetric(vertical: 30),
            margin: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(25),
            ),
            child: CachedNetworkImage(
              imageUrl: prod.image,
              placeholder: (context, url) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 12,
            right: 60,
            child: StreamBuilder(
              stream: api,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: Colors.red.withOpacity(0.20),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                        size: 35,
                      ),
                      onPressed: () {},
                    ),
                  );
                } else {
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data.snapshot.value != null) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color: Colors.red.withOpacity(0.20),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () {
                          Provider.of<BackCode>(context, listen: false)
                              .addorremovefav(
                            prod.id,
                            false,
                          );
                        },
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color: Colors.red.withOpacity(0.20),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () {
                          Provider.of<BackCode>(context, listen: false)
                              .addorremovefav(
                            prod.id,
                            true,
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
