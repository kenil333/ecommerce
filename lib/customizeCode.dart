import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:ecommerce/screens/Buyer/child/category.dart';
import 'package:ecommerce/screens/sellers/child/categoryinseller.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:intl/intl.dart';

class CustomizeCode {
  appBarOfScreens() {
    return PreferredSize(
      child: AppBar(
        backgroundColor: Color(0xFF2874F0),
        brightness: Brightness.dark,
      ),
      preferredSize: Size.fromHeight(0),
    );
  }

  textfeildandIcon(
    String title,
    IconData icon,
    TextEditingController control,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Color(0xFF305F72).withOpacity(0.23),
          ),
        ],
      ),
      child: Row(
        children: [
          title == 'Contact Number'
              ? Container(
                  padding: EdgeInsets.only(left: 5, right: 8),
                  child: Text(
                    '+91',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF305F72),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: TextField(
                obscureText: title == 'Password' ? true : false,
                controller: control,
                keyboardType: (title == 'Contact Number' || title == 'Pincode')
                    ? TextInputType.number
                    : TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF305F72),
                ),
                decoration: InputDecoration(
                  hintText: title,
                  border: InputBorder.none,
                ),
                maxLines: title == 'Address' ? 2 : 1,
              ),
            ),
          ),
          Icon(
            icon,
            color: Color(0xFF305F72),
          ),
        ],
      ),
    );
  }

  indicatorForLoginOrRegistration(
    String indicateText,
    BuildContext context,
    Function func,
    String secondIniText,
  ) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            indicateText,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: func,
            child: Text(
              secondIniText,
              style: TextStyle(
                color: Color(0xFF2D2942),
                letterSpacing: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  customButtonforLoginAndSignup(
    Size size,
    Function func,
    String title,
  ) {
    return Container(
      width: size.width * 0.7,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFF3383CD),
        //     Color(0xFF11249F),
        //   ],
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        // ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Color(0xFF305F72).withOpacity(0.3),
          ),
        ],
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: func,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 1.5,
          ),
        ),
        textColor: Color(0xFFFFC344),
        color: Color(0xFF2D2942),
      ),
    );
  }

  firstBadgeforMostOFScrren(String title, Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 20),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: size.width * 0.2,
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: size.width * 0.07,
                color: Color(0xFF305F72),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: size.width * 0.2),
            width: size.width * 0.8,
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Color(0xFF305F72),
              ),
            ),
          ),
        ],
      ),
    );
  }

  sliderForBoth(
    List<AdvertiseMent> images,
    Size size,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 40),
      width: double.infinity,
      alignment: Alignment.center,
      child: CarouselSlider(
        items: images
            .map(
              (i) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CategoryDifferentScreen(
                        i.keyword,
                        'Ad',
                      ),
                    ),
                  );
                },
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: i.imageURL,
                    placeholder: (context, url) => Container(
                      color: Colors.black12,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: size.height * 0.25,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }

  finalBadgeforAddandUpdatedetail(
    Function func,
    Size size,
    String title,
  ) {
    return InkWell(
      onTap: func,
      child: Container(
        width: size.width * 0.8,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: size.width * 0.1,
          right: size.width * 0.1,
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: Color(0xFF305F72).withOpacity(0.3),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: size.width * 0.055,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  textFieldWidget(TextEditingController keycontroller, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Color(0xFF305F72).withOpacity(0.23),
          ),
        ],
      ),
      child: TextField(
        controller: keycontroller,
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFF305F72),
        ),
        decoration: InputDecoration(
          hintText: title,
          border: InputBorder.none,
        ),
      ),
    );
  }

  singleTextFeildBottomSheet(
    Size size,
    String work,
    String title,
    TextEditingController control,
    Function add,
    BuildContext context,
    String hintTxt,
  ) {
    return Container(
      width: size.width,
      height: title == 'Description' ? size.height * 0.5 : size.height * 0.3,
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
            padding: EdgeInsets.only(top: 5),
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
            margin: EdgeInsets.only(top: 25, left: 30),
            child: Text(
              '$work $title',
              style: TextStyle(
                color: Color(0xFF305F72),
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0xFF305F72).withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              controller: control,
              maxLines: title == 'Description' ? 5 : 1,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF305F72),
              ),
              decoration: InputDecoration(
                hintText: hintTxt,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            width: size.width,
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                InkWell(
                  onTap: () {
                    add(title);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3383CD),
                          Color(0xFF11249F),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 20,
                          color: Color(0xFF305F72).withOpacity(0.3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$work',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: size.width * 0.055,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  singleproductStemp(
    Function func,
    String image,
    String name,
    double price,
    Size size,
  ) {
    return InkWell(
      onTap: func,
      child: Container(
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
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.01,
                ),
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.01,
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFF305F72),
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹ ${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Color(0xFF305F72),
                      fontSize: size.width * 0.042,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  firstSearchWidget() {
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 30,
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: TextField(
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF305F72),
                ),
                decoration: InputDecoration(
                  hintText: 'Find the Product...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: Color(0xFF305F72),
          ),
        ],
      ),
    );
  }

  categoryListWidget(
    List<Category> categories,
    Size size,
    BuildContext context,
    String from,
  ) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Search by Category',
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF305F72),
                ),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: categories.length,
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: () {
                  if (from == 'Buyer') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => CategoryDifferentScreen(
                          categories[i].name,
                          'Category',
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            CategoryDifferentScreenInSellers(categories[i]),
                      ),
                    );
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                        child: CachedNetworkImage(
                          imageUrl: categories[i].image,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        categories[i].name,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  orderList(
    Function func,
    Size size,
    String title,
    String total,
    String date,
    String address,
  ) {
    IconData _icondata() {
      IconData ico;
      if (title == 'Completed') {
        ico = Icons.beenhere_rounded;
      } else if (title == 'Packed') {
        ico = Icons.delivery_dining;
      } else {
        ico = Icons.access_time_outlined;
      }
      return ico;
    }

    return InkWell(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 25,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
              color: Color(0xFF305F72).withOpacity(0.23),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹ $total',
                    style: TextStyle(
                      fontSize: size.width * 0.06,
                      color: Color(0xFF305F72),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 20),
                    child: Text(
                      address,
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _icondata(),
              color: title == 'Completed' ? Colors.green : Colors.red,
              size: size.width * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  orderStustusatTop(
    String statusText,
    IconData icon,
    String nu,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            color: Color(0xFF305F72).withOpacity(0.23),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color:
                        statusText == 'Completed' ? Colors.green : Colors.red,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF305F72),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
          Text(
            '#$nu',
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFF305F72),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _orderTrackingWidget(
    IconData icon,
    String lable,
    Size size,
    String date,
    Color icolor,
    Color linecolor,
  ) {
    if (lable != 'Ordered') {
      if (date != 'No') {
        DateTime da = DateTime.parse(date);
        date = DateFormat('MMMM dd, yyyy').format(da);
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            Icon(
              icon,
              color: icolor,
              size: 30,
            ),
            lable == 'Delivered'
                ? SizedBox()
                : Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1.0,
                          color: linecolor,
                        ),
                      ),
                    ),
                    height: 50,
                  ),
          ],
        ),
        SizedBox(width: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lable,
              style: TextStyle(
                color: Color(0xFF305F72),
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            date != 'No'
                ? Text(
                    date,
                    style: TextStyle(
                      color: Color(0xFF305F72),
                      fontSize: size.width * 0.04,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  _singleIteamInPrroductDetail(
    Size size,
    ProdOd prod,
  ) {
    return Container(
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
                  imageUrl: prod.imaeg,
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
                        '1x',
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
                    Text(
                      '₹ ${prod.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Color(0xFF305F72),
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
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

  producDetailInOrder(
    Size size,
    List<ProdOd> prod,
    String status,
    DateTime orderdate,
    String asigndate,
    String pakeddate,
    String deliverdate,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            color: Color(0xFF305F72).withOpacity(0.23),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Product Detail',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[600],
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: prod.length,
            itemBuilder: (ctx, i) {
              return _singleIteamInPrroductDetail(size, prod[i]);
            },
          ),
          _orderTrackingWidget(
            Icons.beenhere_rounded,
            'Ordered',
            size,
            '${DateFormat('MMMM dd, yyyy').format(orderdate)}',
            Colors.green,
            status == 'Panding' ? Colors.red : Colors.green,
          ),
          _orderTrackingWidget(
            Icons.access_time_outlined,
            'Delivery Assigned',
            size,
            asigndate,
            status == 'Panding' ? Colors.red : Colors.green,
            status == 'Panding' || status == 'Assigned'
                ? Colors.red
                : Colors.green,
          ),
          _orderTrackingWidget(
            Icons.access_time_outlined,
            'Packed',
            size,
            pakeddate,
            status == 'Panding' || status == 'Assigned'
                ? Colors.red
                : Colors.green,
            status == 'Completed' ? Colors.green : Colors.red,
          ),
          _orderTrackingWidget(
            Icons.delivery_dining,
            'Delivered',
            size,
            deliverdate,
            status == 'Completed' ? Colors.green : Colors.red,
            Colors.green,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  shippingDetailInOrder(
    Size size,
    String name,
    String address,
    String phone,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            color: Color(0xFF305F72).withOpacity(0.23),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              'Shipping Detail',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[600],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Color(0xFF305F72),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              address,
              style: TextStyle(
                color: Color(0xFF305F72),
                fontSize: size.width * 0.04,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  'Phone Number : ',
                  style: TextStyle(
                    color: Color(0xFF305F72),
                    fontSize: size.width * 0.04,
                  ),
                ),
                Text(
                  '+91 $phone',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF305F72),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _chargesInOrderDetail(
    Size size,
    double charge,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Shipping charg',
              style: TextStyle(
                color: Color(0xFF305F72),
                fontSize: size.width * 0.04,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              '₹ ${charge.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Color(0xFF305F72),
              ),
            ),
          ),
        ],
      ),
    );
  }

  priceDetailInOrder(
    Size size,
    List<ProdOd> prod,
    double charge,
    double total,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            color: Color(0xFF305F72).withOpacity(0.23),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Price Detail',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[600],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: prod.length,
            itemBuilder: (ctx, i) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${prod[i].count} x ${prod[i].name}',
                        style: TextStyle(
                          color: Color(0xFF305F72),
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        '₹ ${prod[i].tot.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF305F72),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          _chargesInOrderDetail(size, charge),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Your Final Price :',
                style: TextStyle(
                  color: Color(0xFF305F72),
                  fontSize: size.width * 0.04,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              '₹ ${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: size.width * 0.1,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  buttonForOrderDetailScreen(
    BuildContext context,
    Widget widget,
    String title,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 20),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                showBottomSheet(
                  context: context,
                  builder: (context) => widget,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      color: Color(0xFF305F72).withOpacity(0.3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  tagLineforDeliveryMan(String title, Size size) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, bottom: 15),
      width: size.width,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF305F72),
          fontSize: size.width * 0.075,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  coustomeDiolog(String message, BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: size.height * 0.25,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/wrong.png',
                fit: BoxFit.cover,
                height: size.height * 0.1,
              ),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: size.width * 0.055,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  coustomeSnak(String title, Color color, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
      ),
    );
  }

  disabletextfeild(
    Size size,
    String title,
    TextEditingController controller,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              fontSize: size.width * 0.05,
              color: Color(0xFF305F72),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.01),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0xFF305F72).withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              textCapitalization: title == 'Description'
                  ? TextCapitalization.sentences
                  : TextCapitalization.words,
              controller: controller,
              enabled: false,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Color(0xFF305F72),
              ),
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
              ),
              maxLines: title == 'Description' ? 8 : 1,
              keyboardType: (title == 'Price' ||
                      title == 'Position' ||
                      title == 'Product-ID')
                  ? TextInputType.number
                  : TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }

  coustomTitlewithTextFeild(
    Size size,
    String title,
    TextEditingController controller,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              fontSize: size.width * 0.05,
              color: Color(0xFF305F72),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.01),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0xFF305F72).withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              textCapitalization: title == 'Description'
                  ? TextCapitalization.sentences
                  : TextCapitalization.words,
              controller: controller,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Color(0xFF305F72),
              ),
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
              ),
              maxLines: title == 'Description' ? 8 : 1,
              keyboardType: (title == 'Price' ||
                      title == 'Delivery-Charge' ||
                      title == 'Position' ||
                      title == 'Product-ID')
                  ? TextInputType.number
                  : TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }

  coustomDropDownWithTitle(
    Size size,
    String target,
    Function func,
    String title,
    List<String> targetList,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              fontSize: size.width * 0.05,
              color: Color(0xFF305F72),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.01),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0xFF305F72).withOpacity(0.23),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: target,
                style: TextStyle(color: Colors.black),
                items: targetList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Color(0xFF305F72),
                      ),
                    ),
                  );
                }).toList(),
                hint: Text('Choose $title'),
                onChanged: (String statusValue) {
                  func(statusValue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  addphoto(Size size, Function func) {
    return Container(
      width: double.infinity,
      height: size.height * 0.25,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.055),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.12),
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
      child: InkWell(
        onTap: () {
          func();
        },
        child: Icon(
          Icons.add_circle,
          color: Colors.green,
          size: size.width * 0.3,
        ),
      ),
    );
  }

  cacheimage(Size size, String image, Function func) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.35,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.055),
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.12),
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
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.02,
          right: size.width * 0.15,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.edit,
              size: size.width * 0.08,
              color: Color(0xFF305F72),
            ),
            onPressed: () {
              func();
            },
          ),
        ),
      ],
    );
  }

  photoAddorEdit(Size size, File imagefile, Function func) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.35,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.055),
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.12),
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
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.file(
              imagefile,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.02,
          right: size.width * 0.15,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.edit,
              size: size.width * 0.08,
              color: Color(0xFF305F72),
            ),
            onPressed: () {
              func();
            },
          ),
        ),
      ],
    );
  }

  datanot(
    Size size,
    String title,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            width: double.infinity,
            child: Image.asset(
              'assets/images/dnf.png',
              height: size.height * 0.45,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.055,
                fontWeight: FontWeight.bold,
                color: Color(0xFF305F72),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  snak(String title, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  truediload(String message, BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: size.height * 0.25,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/abc.gif',
                fit: BoxFit.cover,
                height: size.height * 0.1,
              ),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: size.width * 0.055,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
