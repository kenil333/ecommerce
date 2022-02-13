import 'package:flutter/material.dart';

class SliderUpdateBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.25,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Container(
            margin: EdgeInsets.only(top: 20, left: 30),
            child: Text(
              'Choose Image from Gallary',
              style: TextStyle(
                color: Color(0xFF305F72),
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 30),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Icon(
                        Icons.photo_album_sharp,
                        color: Colors.red,
                        size: 40,
                      ),
                      Text(
                        'gallery',
                        style: TextStyle(
                          color: Color(0xFF305F72),
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
