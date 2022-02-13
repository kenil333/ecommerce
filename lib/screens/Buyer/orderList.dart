import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/orderDetail.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _phone = Provider.of<BackCode>(context, listen: false).me.phone;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Order')
        .orderByChild('C-Phone')
        .equalTo(_phone)
        .onValue;
    return DefaultTabController(
      length: 2,
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
                  icon: Icon(Icons.beenhere_rounded),
                )
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
                    return b.date.compareTo(a.date);
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
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: _remain.length,
                                  itemBuilder: (context, i) =>
                                      CustomizeCode().orderList(
                                    () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => OrderDetailScrren(
                                            //'Buyer',
                                            false,
                                            false,
                                            false,
                                            true,
                                            _remain[i],
                                          ),
                                        ),
                                      );
                                    },
                                    size,
                                    _remain[i].status,
                                    _remain[i].total.toStringAsFixed(2),
                                    '${DateFormat('MMMM dd, yyyy').format(_remain[i].date)}',
                                    _remain[i].address,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : CustomizeCode().datanot(
                            size,
                            'you don\'t have any Order Yet !',
                          ),
                    _completed.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: _completed.length,
                                  itemBuilder: (context, i) =>
                                      CustomizeCode().orderList(
                                    () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => OrderDetailScrren(
                                            //'Buyer',
                                            false,
                                            false,
                                            false,
                                            true,
                                            _completed[i],
                                          ),
                                        ),
                                      );
                                    },
                                    size,
                                    _completed[i].status,
                                    _completed[i].total.toStringAsFixed(2),
                                    '${DateFormat('MMMM dd, yyyy').format(_completed[i].date)}',
                                    _completed[i].address,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : CustomizeCode().datanot(
                            size,
                            'you don\'t have any Compelted Order Yet !',
                          ),
                  ],
                );
              } else {
                return TabBarView(
                  children: [
                    CustomizeCode().datanot(
                      size,
                      'you don\'t have any Order Yet !',
                    ),
                    CustomizeCode().datanot(
                      size,
                      'you don\'t have any Compelted Order Yet !',
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
