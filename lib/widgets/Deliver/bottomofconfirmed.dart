import 'package:flutter/material.dart';

class BottumSheetOfConfirmed extends StatefulWidget {
  final TextEditingController control;
  final Function func;
  BottumSheetOfConfirmed(this.control, this.func);

  @override
  _BottumSheetOfConfirmedState createState() => _BottumSheetOfConfirmedState();
}

class _BottumSheetOfConfirmedState extends State<BottumSheetOfConfirmed> {
  bool _queryrun = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.32,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF305F72),
            blurRadius: 25,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.5,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: size.width * 0.045,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0xFF305F72).withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              controller: widget.control,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: Color(0xFF305F72),
              ),
              decoration: InputDecoration(
                hintText: 'Delivery Code',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Container(
            child: Row(
              children: [
                Expanded(child: Container()),
                _queryrun
                    ? Container(
                        width: size.width * 0.2,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: InkWell(
                          onTap: () {
                            widget.func(
                              size,
                              () {
                                setState(() {
                                  _queryrun = true;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              () {
                                setState(() {
                                  _queryrun = false;
                                });
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08,
                              vertical: size.height * 0.015,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
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
                              'Confirm',
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
