import 'package:ecommerce/modules/generalClasses.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/orderDetail.dart';
import 'package:intl/intl.dart';

class DeliveryManagementForSellersScrren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance.reference().child('Order').onValue;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Color(0xFF2874F0),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.access_time_outlined),
                ),
                Tab(
                  icon: Icon(Icons.delivery_dining),
                ),
                Tab(
                  icon: Icon(Icons.beenhere_rounded),
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
                List<OrderData> _panding = [];
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
                    } else if (value['Status'] == 'Panding') {
                      _panding.add(
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
                if (_panding.length > 1) {
                  _panding.sort((a, b) {
                    return a.date.compareTo(b.date);
                  });
                }
                if (_completed.length > 1) {
                  _completed.sort((a, b) {
                    return b.date.compareTo(a.date);
                  });
                }
                if (_remain.length > 1) {
                  _remain.sort((a, b) {
                    return a.date.compareTo(b.date);
                  });
                }
                return TabBarView(
                  children: [
                    _panding.isNotEmpty
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
                                  itemCount: _panding.length,
                                  itemBuilder: (context, i) =>
                                      CustomizeCode().orderList(
                                    () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => OrderDetailScrren(
                                            //'Buyer',
                                            true,
                                            false,
                                            false,
                                            false,
                                            _panding[i],
                                          ),
                                        ),
                                      );
                                    },
                                    size,
                                    _panding[i].status,
                                    _panding[i].total.toStringAsFixed(2),
                                    '${DateFormat('MMMM dd, yyyy').format(_panding[i].date)}',
                                    _panding[i].address,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : CustomizeCode().datanot(
                            size,
                            'There is Nothing in Pending to Assign Delivery !',
                          ),
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
                                            false,
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
                            'There is Nothing in Pending Delivery Orders !',
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
                                            false,
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
                            'There is Nothing in Compelted Orders !',
                          ),
                  ],
                );
              } else {
                return TabBarView(
                  children: [
                    CustomizeCode().datanot(
                      size,
                      'There is Nothing in Pending to Assign Delivery !',
                    ),
                    CustomizeCode().datanot(
                      size,
                      'There is Nothing in Pending Delivery Orders !',
                    ),
                    CustomizeCode().datanot(
                      size,
                      'There is Nothing in Compelted Orders !',
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
