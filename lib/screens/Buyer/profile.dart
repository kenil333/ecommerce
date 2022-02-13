import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Buyer/Profile/basicDetail.dart';
import 'package:ecommerce/widgets/Buyer/Profile/accountstemps.dart';
import 'package:ecommerce/screens/Buyer/Dashboard/cart.dart';
import 'package:ecommerce/screens/Buyer/Dashboard/favorite.dart';
import 'package:ecommerce/screens/Buyer/child/updateDetail.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final Function func;
  ProfileScreen(this.func);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Me _me;
  bool _loading = true;

  void _change(
    String name,
    String email,
    String address,
    String pincode,
    bool mal,
  ) {
    _me.name = name;
    _me.email = email;
    _me.address = address;
    _me.postcode = pincode;
    _me.sex = mal;
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      _me = Provider.of<BackCode>(context, listen: false).me;
      _loading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    BasicDetailWidget(
                      _me,
                      _change,
                    ),
                    AccouuntStempsWidget(
                      'My Email-Id',
                      _me.email,
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UpdateBuyerDetailScreen(
                              _change,
                              _me,
                            ),
                          ),
                        );
                      },
                    ),
                    AccouuntStempsWidget(
                      'My Address',
                      '${_me.address} ${_me.postcode}.',
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UpdateBuyerDetailScreen(
                              _change,
                              _me,
                            ),
                          ),
                        );
                      },
                    ),
                    AccouuntStempsWidget(
                      'My Orders',
                      ' ',
                      () {
                        widget.func();
                      },
                    ),
                    AccouuntStempsWidget(
                      'My Cart',
                      ' ',
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => CartScreen(),
                          ),
                        );
                      },
                    ),
                    AccouuntStempsWidget(
                      'My Favorite',
                      '',
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => FavoriteScreen(),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<BackCode>(context, listen: false)
                            .logout(() {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          bottom: 25,
                          top: 25,
                          left: 40,
                          right: 40,
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
                          'Logout',
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
      ),
    );
  }
}
