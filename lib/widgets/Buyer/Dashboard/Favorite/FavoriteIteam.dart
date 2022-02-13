import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce/screens/Buyer/Dashboard/produtDetail.dart';

class FavoriteIteamWidget extends StatelessWidget {
  final String id;
  FavoriteIteamWidget(this.id);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Products prod =
        Provider.of<BackCode>(context, listen: false).returnprod(id);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(prod),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: size.width * 0.2,
                  height: size.width * 0.2,
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prod.name,
                          style: TextStyle(
                            color: Color(0xFF305F72),
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '₹ ${prod.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Color(0xFF305F72),
                            fontSize: size.width * 0.04,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<BackCode>(context, listen: false)
                              .addorremovefav(
                            prod.id,
                            false,
                          );
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
