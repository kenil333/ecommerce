import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/screens/sellers/appSettings/categoryAdd.dart';
import 'package:ecommerce/screens/sellers/appSettings/categoryUpdate.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../customizeCode.dart';

class CategoryListInSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Category').onValue;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CustomizeCode().firstBadgeforMostOFScrren(
                    'Category',
                    size,
                    context,
                  ),
                  Positioned(
                    top: size.height * 0.02,
                    right: size.width * 0.02,
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: size.width,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategoryAddScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: size.width * 0.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: api,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snap,
                ) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snap.hasData &&
                        !snap.hasError &&
                        snap.data.snapshot.value != null) {
                      List<Category> _category = [];
                      snap.data.snapshot.value.forEach(
                        (key, value) {
                          _category.add(
                            Category(
                              id: key,
                              name: value['Name'],
                              image: value['Image'],
                              position: int.parse(value['Position']),
                            ),
                          );
                        },
                      );
                      if (_category.length > 1) {
                        _category.sort((a, b) {
                          return a.position.compareTo(b.position);
                        });
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(20),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: _category.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CategoryUpdateScreen(
                                    _category[i],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 15,
                                right: 15,
                                bottom: 20,
                                top: 10,
                              ),
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
                                      imageUrl: _category[i].image,
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
                                    _category[i].name,
                                    style: TextStyle(
                                      color: Color(0xFF305F72),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return CustomizeCode().datanot(
                        size,
                        'Please Insert Category in the DataBase List !',
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
