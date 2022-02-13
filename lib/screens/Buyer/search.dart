import 'package:ecommerce/modules/generalClasses.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Category').onValue;
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
                        'Buyer',
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
