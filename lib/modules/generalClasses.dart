import 'package:flutter/material.dart';

class Me {
  final String phone;
  String name;
  String email;
  String address;
  String postcode;
  bool sex;
  Me({
    @required this.phone,
    @required this.name,
    @required this.email,
    @required this.address,
    @required this.postcode,
    @required this.sex,
  });
}

class Products {
  final String id;
  final String name;
  final String image;
  final double price;
  final double dcharge;
  final String category;
  final String ptype;
  final String atype;
  final String description;
  Products({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.price,
    @required this.dcharge,
    @required this.category,
    @required this.ptype,
    @required this.atype,
    @required this.description,
  });
}

class CartC {
  final String id;
  final int count;
  final double price;
  CartC({
    @required this.id,
    @required this.count,
    @required this.price,
  });
}

class OrderProd {
  final String id;
  final String name;
  final String image;
  final double price;
  final double dcharge;
  final int count;
  final double total;
  OrderProd({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.price,
    @required this.dcharge,
    @required this.count,
    @required this.total,
  });
}

class ProdOd {
  final String id;
  final String name;
  final String imaeg;
  final double price;
  final double tot;
  final int count;
  ProdOd({
    @required this.id,
    @required this.name,
    @required this.imaeg,
    @required this.price,
    @required this.tot,
    @required this.count,
  });
}

class OrderData {
  final String fireid;
  final String id;
  final String status;
  final double total;
  final double subtot;
  final double shiping;
  final DateTime date;
  final String address;
  final String name;
  final String phone;
  final String assigndate;
  final String pakedate;
  final String deliverdate;
  final String safeword;
  List<ProdOd> prod;
  OrderData({
    @required this.fireid,
    @required this.id,
    @required this.status,
    @required this.total,
    @required this.subtot,
    @required this.shiping,
    @required this.date,
    @required this.address,
    @required this.name,
    @required this.phone,
    @required this.assigndate,
    @required this.pakedate,
    @required this.deliverdate,
    this.safeword,
    @required this.prod,
  });
}

class AdvertiseMent {
  final String id;
  final String imageURL;
  final String keyword;
  final int position;

  AdvertiseMent({
    @required this.id,
    @required this.imageURL,
    @required this.keyword,
    @required this.position,
  });
}

class Category {
  final String id;
  final String name;
  final String image;
  final int position;
  Category({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.position,
  });
}

class DeliveryMan {
  final String phone;
  String name;
  String email;
  String address;
  String pincode;
  bool mal;
  DeliveryMan({
    @required this.phone,
    @required this.name,
    @required this.email,
    @required this.address,
    @required this.pincode,
    @required this.mal,
  });
}

class Deliverynamesex {
  final String phone;
  final String name;
  final bool mal;
  Deliverynamesex({
    @required this.phone,
    @required this.name,
    @required this.mal,
  });
}
