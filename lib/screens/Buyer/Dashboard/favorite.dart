import 'package:ecommerce/provider/BackCode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Buyer/Dashboard/Favorite/FavoriteIteam.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _phone = Provider.of<BackCode>(context, listen: false).me.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Like')
        .child(_phone)
        .onValue;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomizeCode().firstBadgeforMostOFScrren(
                'Favorite',
                size,
                context,
              ),
              StreamBuilder(
                stream: api,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snap.hasData &&
                        !snap.hasError &&
                        snap.data.snapshot.value != null) {
                      List<String> _ids = [];
                      snap.data.snapshot.value.forEach(
                        (key, value) {
                          _ids.add(key);
                        },
                      );
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: _ids.length,
                        itemBuilder: (ctx, i) {
                          return FavoriteIteamWidget(_ids[i]);
                        },
                      );
                    } else {
                      return CustomizeCode().datanot(
                        size,
                        'Please Enter the Products in the Favorite !',
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
