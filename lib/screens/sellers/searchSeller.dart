import 'package:ecommerce/modules/generalClasses.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';

class SearchForSellerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Category').onValue;
    // List<String> categories = [
    //   'Accessories & Supplies',
    //   'Camera & Photo',
    //   'Car & Vehicle Electronics',
    //   'Cell Phones & Accessories',
    //   'Computers & Accessories',
    //   'GPS & Navigation',
    //   'Headphones',
    //   'Home Audio',
    //   'Office Electronics',
    //   'Portable Audio & Video',
    //   'Security & Surveillance',
    //   'Service Plans',
    //   'Television & Video',
    //   'Video Game Consoles & Accessories',
    //   'Video Projectors',
    //   'Wearable Technology',
    //   'eBook Readers & Accessories',
    // ];
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: StreamBuilder(
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomizeCode().firstSearchWidget(),
                      CustomizeCode().categoryListWidget(
                        _category,
                        size,
                        context,
                        'Seller',
                      ),
                    ],
                  ),
                );
              } else {
                return CustomizeCode().datanot(
                  size,
                  'Category List is Empty !',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
