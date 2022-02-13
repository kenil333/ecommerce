import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/screens/deliveryMan/profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../customizeCode.dart';
import './deliveryWork.dart';
import './historyOfWork.dart';

class TabBottomScreenOfDeliveryMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Me _me = Provider.of<BackCode>(context, listen: false).me;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Order')
        .orderByChild('DeliveryMan')
        .equalTo(_me.phone)
        .onValue;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('Do you want to exit ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );

        return false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xFFFAFAFA),
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Color(0xFF2874F0),
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.delivery_dining),
                  ),
                  Tab(
                    icon: Icon(Icons.history_edu_rounded),
                  ),
                  Tab(
                    icon: Icon(Icons.account_circle_outlined),
                  ),
                ],
                indicatorColor: Colors.green,
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
          body: StreamBuilder(
            stream: api,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return TabBarView(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              } else {
                if (snap.hasData &&
                    !snap.hasError &&
                    snap.data.snapshot.value != null) {
                  List<OrderData> _remain = [];
                  List<OrderData> _completed = [];
                  snap.data.snapshot.value.forEach(
                    (key, value) {
                      if (value['Status'] == 'Completed') {
                        _completed.add(
                          OrderData(
                            fireid: key,
                            id: value['Id'],
                            status: value['Status'],
                            total: double.parse(value['Total']),
                            subtot: double.parse(value['SubTotal']),
                            shiping: double.parse(value['Shiping']),
                            date: DateTime.parse(value['Date']),
                            address: value['C-Address'],
                            name: value['C-Name'],
                            phone: value['C-Phone'],
                            assigndate: value['AssignDate'],
                            pakedate: value['PackedDate'],
                            deliverdate: value['DeliveredDate'],
                            prod: (value['Product'] as List<dynamic>)
                                .map(
                                  (e) => ProdOd(
                                    id: e['P-ID'],
                                    name: e['P-Name'],
                                    imaeg: e['P-Image'],
                                    price: double.parse(e['P-Price']),
                                    tot: double.parse(e['P-Total']),
                                    count: int.parse(e['P-Count']),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      } else {
                        _remain.add(
                          OrderData(
                            fireid: key,
                            id: value['Id'],
                            status: value['Status'],
                            total: double.parse(value['Total']),
                            subtot: double.parse(value['SubTotal']),
                            shiping: double.parse(value['Shiping']),
                            date: DateTime.parse(value['Date']),
                            address: value['C-Address'],
                            name: value['C-Name'],
                            phone: value['C-Phone'],
                            assigndate: value['AssignDate'],
                            pakedate: value['PackedDate'],
                            deliverdate: value['DeliveredDate'],
                            safeword: value['SafeWord'],
                            prod: (value['Product'] as List<dynamic>)
                                .map(
                                  (e) => ProdOd(
                                    id: e['P-ID'],
                                    name: e['P-Name'],
                                    imaeg: e['P-Image'],
                                    price: double.parse(e['P-Price']),
                                    tot: double.parse(e['P-Total']),
                                    count: int.parse(e['P-Count']),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }
                    },
                  );
                  if (_remain.length > 1) {
                    _remain.sort((a, b) {
                      return a.date.compareTo(b.date);
                    });
                  }
                  if (_completed.length > 1) {
                    _completed.sort((a, b) {
                      return b.date.compareTo(a.date);
                    });
                  }
                  return TabBarView(
                    children: [
                      _remain.isNotEmpty
                          ? DeliveryWorkScreen(_remain)
                          : CustomizeCode().datanot(
                              size,
                              'Please wait for Admin to Assign some work !',
                            ),
                      _completed.isNotEmpty
                          ? HistoryOfWorkScreen(_completed)
                          : CustomizeCode().datanot(
                              size,
                              'You don\'t have any Compelted Work Yet !',
                            ),
                      ProfileInDeliveryScreen(
                        _me,
                        _completed.length.toString(),
                      ),
                    ],
                  );
                } else {
                  return TabBarView(
                    children: [
                      CustomizeCode().datanot(
                        size,
                        'Please wait for Admin to Assign some work !',
                      ),
                      CustomizeCode().datanot(
                        size,
                        'You don\'t have any Compelted Work Yet !',
                      ),
                      ProfileInDeliveryScreen(
                        _me,
                        '0',
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
