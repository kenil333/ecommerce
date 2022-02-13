import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfCartIteamsWidget extends StatelessWidget {
  final CartC cart;
  final int i;
  final int l;
  ListOfCartIteamsWidget(this.cart, this.i, this.l);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Products prod =
        Provider.of<BackCode>(context, listen: false).returnprod(cart.id);
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: i == l ? size.height * 0.21 : 20,
      ),
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
                        '₹ ${cart.price.toStringAsFixed(2)}',
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
                            .addorremovecart(
                          cart.id,
                          cart.count,
                          prod.price,
                          false,
                        );
                      },
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: Color(0xFF305F72),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${cart.count}',
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<BackCode>(context, listen: false)
                            .addorremovecart(
                          cart.id,
                          cart.count,
                          prod.price,
                          true,
                        );
                      },
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF305F72),
                      ),
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
    );
  }
}
