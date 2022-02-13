import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:ecommerce/modules/generalClasses.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../customizeCode.dart';

class BackCode with ChangeNotifier {
  final dbRef = FirebaseDatabase.instance.reference();
  final stgRef = FirebaseStorage.instance.ref();

  Me me;

  List<Products> _product = [];
  List<Products> get product {
    return [..._product];
  }

  List<Products> _iteams = [];
  List<Products> get items {
    return [..._iteams];
  }

  void allowregister(
    String phone,
    Function done,
    Function notdone,
    Function err,
  ) async {
    await dbRef.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
    }).then((DataSnapshot snap) {
      if (snap.value == null) {
        done();
      } else {
        notdone();
      }
    });
  }

  void allowtoforgot(
    String phone,
    Function done,
    Function notdone,
    Function err,
  ) async {
    await dbRef.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
    }).then((DataSnapshot snap) {
      if (snap.value == null) {
        notdone();
      } else {
        done();
      }
    });
  }

  void forgot(
    String phone,
    String password,
    Function done,
    Function err,
  ) async {
    await dbRef.child('Users').child(phone).update(
      {
        'Password': password,
      },
    ).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void register(
    String phone,
    String name,
    String email,
    String password,
    String address,
    String pincode,
    Function done,
    Function err,
  ) async {
    await dbRef.child('Users').child(phone).set({
      'Name': name,
      'Email': email,
      'Password': password,
      'Address': address,
      'Pincode': pincode,
      'Who': 'Customer',
      'Sex': true,
    }).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void login(
    String phone,
    String password,
    Function done,
    Function nophone,
    Function nopass,
    Function err,
  ) async {
    await dbRef.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) async {
        if (snap.value == null) {
          nophone();
        } else {
          if (snap.value['Password'] != password) {
            nopass();
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('Phone', phone).then(
              (_) async {
                await prefs
                    .setString('Password', snap.value['Password'])
                    .then((_) {
                  if (snap.value['Who'] == 'Customer' ||
                      snap.value['Who'] == 'Delivery') {
                    me = Me(
                      phone: phone,
                      name: snap.value['Name'],
                      email: snap.value['Email'],
                      address: snap.value['Address'],
                      postcode: snap.value['Pincode'],
                      sex: snap.value['Sex'],
                    );
                    notifyListeners();
                  }
                  done(snap.value['Who']);
                });
              },
            );
          }
        }
      },
    );
  }

  void autologin(
    Function nologin,
    Function login,
    Function err,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _phone = prefs.getString('Phone') ?? 'Phone';
    String _password = prefs.getString('Password') ?? 'Password';
    if (_phone == 'Phone' || _password == 'Password') {
      nologin();
    } else {
      await dbRef.child('Users').child(_phone).once().catchError((error) {
        err(error.toString());
      }).then(
        (DataSnapshot snap) async {
          if (snap.value == null) {
            nologin();
          } else {
            if (snap.value['Password'] != _password) {
              nologin();
            } else {
              if (snap.value['Who'] == 'Customer' ||
                  snap.value['Who'] == 'Delivery') {
                me = Me(
                  phone: _phone,
                  name: snap.value['Name'],
                  email: snap.value['Email'],
                  address: snap.value['Address'],
                  postcode: snap.value['Pincode'],
                  sex: snap.value['Sex'],
                );
                notifyListeners();
              }
              login(snap.value['Who']);
            }
          }
        },
      );
    }
  }

  void logout(Function done) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Phone', 'Phone').then((_) async {
      await prefs.setString('Password', 'Password').then((_) {
        done();
      });
    });
  }

  Future<void> fetchRequrements(
    String what,
    String that,
    BuildContext context,
    Function func,
  ) async {
    List<String> adverString = [];
    await dbRef.child(what).once().catchError((error) {
      CustomizeCode().coustomeSnak(
        error.toString(),
        Colors.white,
        context,
      );
    }).then((DataSnapshot snapshot) {
      snapshot.value.forEach((key, value) {
        adverString.add(value[that]);
      });
    }).then((_) {
      func(adverString);
    });
  }

  Future<void> fetchAndSetProductDetail(BuildContext context) async {
    List<Products> prdcs = [];
    await dbRef.child('Product').once().catchError((error) {
      CustomizeCode().coustomeSnak(
        error.toString(),
        Colors.white,
        context,
      );
    }).then(
      (DataSnapshot dataSnapshot) {
        dataSnapshot.value.forEach(
          (key, value) {
            prdcs.add(
              Products(
                id: key,
                name: value['Name'],
                image: value['Image'],
                price: double.parse(value['Price']),
                dcharge: double.parse(value['D-Charge']),
                category: value['Category'],
                ptype: value['P-Type'],
                atype: value['A-Type'],
                description: value['Description'],
              ),
            );
          },
        );
      },
    ).catchError(
      (error) {
        CustomizeCode().coustomeSnak(
          error.toString(),
          Colors.white,
          context,
        );
      },
    ).then((_) {
      _iteams = prdcs;
      notifyListeners();
    });
  }

  Future<void> updateProductDetail(
    String pid,
    String pname,
    String pprice,
    String pdescription,
    BuildContext context,
  ) async {
    await dbRef.child('Products').child(pid).update(
      {
        'Name': pname,
        'Price': pprice,
        'Description': pdescription,
      },
    ).catchError((error) {
      CustomizeCode().coustomeSnak(
        error.toString(),
        Colors.white,
        context,
      );
    });
  }

  Future<void> addAdvertise(
    File image,
    String keyword,
    int position,
    BuildContext context,
  ) async {
    String url;
    final ref = stgRef.child('Advertise').child(keyword + '.jpg');
    await ref.putFile(image).catchError((error) {
      CustomizeCode().coustomeSnak(
        error.toString(),
        Colors.white,
        context,
      );
    }).then((_) async {
      url = await ref.getDownloadURL();
    }).then((_) async {
      await dbRef.child('Advertise').push().set({
        'Keyword': keyword,
        'Position': position,
        'Image': url,
      }).catchError((error) {
        CustomizeCode().coustomeSnak(
          error.toString(),
          Colors.white,
          context,
        );
      });
    });
  }

  Future<void> updateAdvertisement(
    File image,
    String keyword,
    int position,
    String id,
    BuildContext context,
  ) async {
    String url;
    final ref = stgRef.child('Advertise').child(keyword + '.jpg');
    await ref.putFile(image).catchError((error) {
      CustomizeCode().coustomeSnak(
        error.toString(),
        Colors.white,
        context,
      );
    }).then((value) async {
      url = await ref.getDownloadURL();
    }).then((_) async {
      await dbRef.child('Advertise').child(id).update({
        'Keyword': keyword,
        'Position': position,
        'Image': url,
      }).catchError((error) {
        CustomizeCode().coustomeSnak(
          error.toString(),
          Colors.white,
          context,
        );
      });
    });
  }

  Future<void> updateAdwithoutImage(
    String keyword,
    int position,
    String id,
    BuildContext context,
  ) async {
    await dbRef.child('Advertise').child(id).update({
      'Keyword': keyword,
      'Position': position,
    }).catchError((error) {
      CustomizeCode().coustomeSnak(
        error.toString(),
        Colors.white,
        context,
      );
    });
  }

  Future<void> uploadandget(
    String what,
    String name,
    File image,
    Function func,
    Function err,
  ) async {
    final ref = stgRef.child(what).child('$name.jpg');
    await ref.putFile(image).catchError((error) {
      err(error.toString());
    }).then((_) async {
      String url = await ref.getDownloadURL();
      func(url);
    });
  }

  void addcategory(
    String name,
    String position,
    File image,
    Function done,
    Function notdone,
    Function err,
  ) async {
    String _url = '';
    await dbRef
        .child('Category')
        .orderByChild('Name')
        .equalTo(name)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) async {
        if (snap.value == null) {
          await uploadandget(
            'Category',
            name,
            image,
            (String url) {
              _url = url;
            },
            err,
          ).then((_) async {
            await dbRef.child('Category').push().set({
              'Name': name,
              'Image': _url,
              'Position': position,
            }).catchError((error) {
              err(error.toString());
            }).then((_) {
              done();
            });
          });
        } else {
          notdone();
        }
      },
    );
  }

  void updatecatewithoutimage(
    String id,
    String name,
    String position,
    Function done,
    Function err,
  ) async {
    await dbRef.child('Category').child(id).update({
      'Name': name,
      'Position': position,
    }).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void updatecatewithimage(
    String id,
    File image,
    String name,
    String position,
    Function done,
    Function err,
  ) async {
    String _url = '';
    await uploadandget(
      'Category',
      name,
      image,
      (String url) {
        _url = url;
      },
      err,
    ).then((_) async {
      await dbRef.child('Category').child(id).update({
        'Name': name,
        'Image': _url,
        'Position': position,
      }).catchError((error) {
        err(error.toString());
      }).then((_) {
        done();
      });
    });
  }

  void addproduct(
    String id,
    String name,
    String price,
    String dcharge,
    String category,
    String prodtype,
    String adtype,
    String description,
    File image,
    Function done,
    Function notdone,
    Function err,
  ) async {
    String _url = '';
    await dbRef.child('Product').child(id).once().catchError((error) {
      err(error.toString());
    }).then((DataSnapshot snap) async {
      if (snap.value == null) {
        await uploadandget(
          'Product',
          id,
          image,
          (String url) {
            _url = url;
          },
          err,
        ).then(
          (_) async {
            await dbRef.child('Product').child(id).set({
              'Name': name,
              'Image': _url,
              'Price': price,
              'D-Charge': dcharge,
              'Category': category,
              'P-Type': prodtype,
              'A-Type': adtype,
              'Description': description,
            }).catchError((error) {
              err(error.toString());
            }).then((_) {
              done();
            });
          },
        );
      } else {
        notdone();
      }
    });
  }

  void updateproduct(
    String id,
    String name,
    String image,
    String price,
    String dcharge,
    String category,
    String ptype,
    String atype,
    String description,
    Function done,
    Function err,
  ) async {
    dbRef.child('Product').child(id).update({
      'Name': name,
      'Image': image,
      'Price': price,
      'D-Charge': dcharge,
      'Category': category,
      'P-Type': ptype,
      'A-Type': atype,
      'Description': description,
    }).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void productsfetch(
    Function done,
    Function err,
  ) async {
    List<Products> _prod = [];
    await dbRef.child('Product').once().catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          snap.value.forEach(
            (key, value) {
              _prod.add(
                Products(
                  id: key,
                  name: value['Name'],
                  image: value['Image'],
                  price: double.parse(value['Price']),
                  dcharge: double.parse(value['D-Charge']),
                  category: value['Category'],
                  ptype: value['P-Type'],
                  atype: value['A-Type'],
                  description: value['Description'],
                ),
              );
            },
          );
          _product = _prod;
          notifyListeners();
          List<Products> _reco = [];
          List<Products> _sal = [];
          List<Products> _brand = [];
          for (int i = 0; i < _product.length; i++) {
            if (_product[i].ptype == 'Recomanded') {
              _reco.add(
                Products(
                  id: _product[i].id,
                  name: _product[i].name,
                  image: _product[i].image,
                  price: _product[i].price,
                  dcharge: _product[i].dcharge,
                  category: _product[i].category,
                  ptype: _product[i].ptype,
                  atype: _product[i].atype,
                  description: _product[i].description,
                ),
              );
            }
            if (_product[i].ptype == 'On-Sale') {
              _sal.add(
                Products(
                  id: _product[i].id,
                  name: _product[i].name,
                  image: _product[i].image,
                  price: _product[i].price,
                  dcharge: _product[i].dcharge,
                  category: _product[i].category,
                  ptype: _product[i].ptype,
                  atype: _product[i].atype,
                  description: _product[i].description,
                ),
              );
            }
            if (_product[i].ptype == 'Branded') {
              _brand.add(
                Products(
                  id: _product[i].id,
                  name: _product[i].name,
                  image: _product[i].image,
                  price: _product[i].price,
                  dcharge: _product[i].dcharge,
                  category: _product[i].category,
                  ptype: _product[i].ptype,
                  atype: _product[i].atype,
                  description: _product[i].description,
                ),
              );
            }
          }
          done(_reco, _sal, _brand);
        }
      },
    );
  }

  void adandcate(
    String keyword,
    String what,
    Function done,
  ) {
    List<Products> _prod = [];
    for (int i = 0; i < _product.length; i++) {
      if (what == 'Ad') {
        if (_product[i].atype == keyword) {
          _prod.add(
            Products(
              id: _product[i].id,
              name: _product[i].name,
              image: _product[i].image,
              price: _product[i].price,
              dcharge: _product[i].dcharge,
              category: _product[i].category,
              ptype: _product[i].ptype,
              atype: _product[i].atype,
              description: _product[i].description,
            ),
          );
        }
      } else {
        if (_product[i].category == keyword) {
          _prod.add(
            Products(
              id: _product[i].id,
              name: _product[i].name,
              image: _product[i].image,
              price: _product[i].price,
              dcharge: _product[i].dcharge,
              category: _product[i].category,
              ptype: _product[i].ptype,
              atype: _product[i].atype,
              description: _product[i].description,
            ),
          );
        }
      }
    }
    done(_prod);
  }

  Products returnprod(String id) {
    final int i = _product.indexWhere((element) => element.id == id);
    return _product[i];
  }

  void addorremovefav(String id, bool add) async {
    if (add) {
      await dbRef.child('Like').child(me.phone).child(id).set(true);
    } else {
      await dbRef.child('Like').child(me.phone).child(id).remove();
    }
  }

  void addorremovecart(
    String id,
    int count,
    double price,
    bool add,
  ) async {
    if (add) {
      await dbRef.child('Cart').child(me.phone).child(id).set({
        'Count': count + 1,
        'Price': (price * (count + 1)).toStringAsFixed(2),
      });
    } else {
      if (count == 1) {
        await dbRef.child('Cart').child(me.phone).child(id).remove();
      } else {
        await dbRef.child('Cart').child(me.phone).child(id).set({
          'Count': count - 1,
          'Price': (price * (count - 1)).toStringAsFixed(2),
        });
      }
    }
  }

  void order(
    List<OrderProd> prod,
    String shiping,
    String subtot,
    String total,
    Function done,
    Function err,
  ) async {
    const _chars = '0123456789';
    Random _rnd = Random();
    String _safeword = String.fromCharCodes(
      Iterable.generate(
        5,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
    int _oc = 0;
    await dbRef.child('Ordercount').once().catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) async {
        if (snap.value != null) {
          _oc = snap.value;
        }
        await dbRef.child('Order').push().set({
          'Id': (_oc + 1).toString(),
          'SafeWord': _safeword,
          'Status': 'Panding',
          'Total': total,
          'Date': DateFormat('yyyyMMdd').format(DateTime.now()),
          'SubTotal': subtot,
          'Shiping': shiping,
          'C-Name': me.name,
          'C-Phone': me.phone,
          'C-Address': '${me.address} ${me.postcode}',
          'AssignDate': 'No',
          'PackedDate': 'No',
          'DeliveredDate': 'No',
          'DeliveryMan': '0',
          'Product': prod
              .map(
                (e) => {
                  'P-ID': e.id,
                  'P-Name': e.name,
                  'P-Image': e.image,
                  'P-Price': e.price.toStringAsFixed(2),
                  'P-ShipCharge': e.dcharge.toStringAsFixed(2),
                  'P-Count': e.count.toString(),
                  'P-Total': e.total.toStringAsFixed(2),
                },
              )
              .toList(),
        }).catchError((error) {
          err(error.toString());
        }).then(
          (_) async {
            await dbRef.child('Ordercount').set(_oc + 1).catchError((error) {
              err(error.toString());
            }).then((_) async {
              await dbRef.child('Cart').child(me.phone).remove();
            }).then((_) {
              done((_oc + 1).toString());
            });
          },
        );
      },
    );
  }

  void updatemedata(
    String phone,
    String name,
    String email,
    String address,
    String pincode,
    bool mal,
    Function change,
    Function done,
    Function err,
  ) async {
    await dbRef.child('Users').child(phone).update({
      'Name': name,
      'Email': email,
      'Address': address,
      'Pincode': pincode,
      'Sex': mal,
    }).catchError((error) {
      err(error.toString());
    }).then(
      (_) {
        change(name, email, address, pincode, mal);
        me.name = name;
        me.email = email;
        me.address = address;
        me.postcode = pincode;
        me.sex = mal;
        notifyListeners();
        done();
      },
    );
  }

  void adddeliveryman(
    String phone,
    String name,
    String email,
    String address,
    String pincode,
    bool mal,
    Function done,
    Function undone,
    Function err,
  ) async {
    await dbRef.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
    }).then((DataSnapshot snap) async {
      if (snap.value == null) {
        await dbRef.child('Users').child(phone).set({
          'Name': name,
          'Email': email,
          'Address': address,
          'Pincode': pincode,
          'Who': 'Delivery',
          'Sex': mal,
        }).then((_) {
          done();
        });
      } else {
        undone();
      }
    });
  }

  void editdetaildel(
    String phone,
    String what,
    dynamic value,
    Function done,
    Function err,
  ) async {
    await dbRef
        .child('Users')
        .child(phone)
        .child(what)
        .set(value)
        .catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void fetchdel(
    Function done,
    Function err,
  ) async {
    List<Deliverynamesex> _del = [];
    await dbRef
        .child('Users')
        .orderByChild('Who')
        .equalTo('Delivery')
        .once()
        .then((DataSnapshot snap) {
      if (snap.value != null) {
        snap.value.forEach(
          (key, value) {
            _del.add(
              Deliverynamesex(
                phone: key,
                name: value['Name'],
                mal: value['Sex'],
              ),
            );
          },
        );
        done(_del);
      } else {
        done(_del);
      }
    });
  }

  void assigndel(
    String id,
    String phone,
    Function done,
    Function err,
  ) async {
    await dbRef.child('Order').child(id).update({
      'AssignDate': DateFormat('yyyyMMdd').format(DateTime.now()),
      'DeliveryMan': phone,
      'Status': 'Assigned',
    }).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void changestatus(
    String id,
    Function done,
    Function err,
  ) async {
    await dbRef.child('Order').child(id).update({
      'PackedDate': DateFormat('yyyyMMdd').format(DateTime.now()),
      'Status': 'Packed',
    }).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void completorder(
    String id,
    String code,
    String ori,
    Function done,
    Function notdone,
    Function err,
  ) async {
    if (code == ori) {
      await dbRef.child('Order').child(id).update({
        'DeliveredDate': DateFormat('yyyyMMdd').format(DateTime.now()),
        'Status': 'Completed',
      }).catchError((error) {
        err(error.toString());
      }).then((_) {
        done();
      });
    } else {
      notdone();
    }
  }
}
