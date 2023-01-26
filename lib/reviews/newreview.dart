import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eatsafeproject/reviews/listReviewPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';


class addReview extends StatefulWidget {
  const addReview({Key? key}) : super(key: key);

  @override
  State<addReview> createState() => _addReviewState();
}

class _addReviewState extends State<addReview> {
  DateTime now = DateTime.now();
  List users = [];
  List restnames = <String>[];
  bool isLoading = false;
  List items = <String>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(
        "http://www.qrestaurant.acfs.go.th/webapp/api/shop.php?secret=B%E0%B8%81V%E0%B8%AEd%E0%B8%9ABEwq%E0%B8%A0QR89%E0%B8%9E%E0%B8%949L%E0%B8%AD%E0%B8%A24%E0%B8%A24%E0%B8%84%E0%B8%A9%E0%B8%A35%E0%B8%81V%E0%B8%A3i");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = json.decode(utf8.decode(response.bodyBytes))['data'];
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
    for (var user in users) {
      restnames.add(user["rest_name"]);
    }
    items.addAll(restnames);
  }

  final _restaurantReviewcontroller = TextEditingController();
  String savename = '';
  double resrating = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xE6131619),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 44, 12, 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.black26,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Container(
                        width: 392.273,
                        height: 800,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: Color(0x5D000000),
                              offset: Offset(0, -2),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Add Review',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Fill out the details below to add a review.',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: Theme(
                                data: ThemeData(
                                  textTheme: TextTheme(
                                      subtitle1:
                                          TextStyle(color: Colors.white)),
                                ),
                                child: DropdownSearch<dynamic>(
                                  onChanged: (newval) {
                                    setState(() {
                                      savename = newval.toString();
                                    });
                                  },
                                  popupProps: PopupProps.menu(
                                    fit: FlexFit.loose,
                                    menuProps: MenuProps(
                                      backgroundColor: Color(0xE6131619),
                                      elevation: 0,
                                    ),
                                  ),
                                  items: restnames,
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: 'Restaurant Name',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                      hintText: 'Enter Restaurant Name',
                                      hintStyle: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ),
                              // style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: TextFormField(
                                controller: _restaurantReviewcontroller,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Review Details',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter a Review here...',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                ),
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding:EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child:RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                unratedColor: Colors.grey,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  resrating = rating;
                                  print(rating);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: TextButton(
                                onPressed: () {
                                  final checkname = savename;
                                  final checkrev = _restaurantReviewcontroller.text;
                                  final checkrating = resrating;
                                  if (checkname == "") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text("Please select restaurant name"),
                                            actions: [
                                              FlatButton(
                                                child: Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                  else if (checkrev == "") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text("Please enter restaurant review"),
                                            actions: [
                                              FlatButton(
                                                child: Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                  else if (checkrating == 0) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text("Please give a rating"),
                                            actions: [
                                              FlatButton(
                                                child: Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                  else {

                                    final StoreReview = storeReview(
                                      resName: savename,
                                      resRev: _restaurantReviewcontroller.text,
                                      resRating: resrating,
                                      revDate: DateFormat.yMMMd().format(now),
                                    );

                                    saveReview(StoreReview);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => reviewsList()),
                                    );
                                  }
                                },
                                child: Text(
                                  "  Save Review  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF42BEA5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => reviewsList()),
                                  );
                                },
                                child: Text(
                                  "      Cancel      ",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFF42BEA5)),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ),
                          ],
                        )),
                  )
                ])
                )
              ],
            )));
  }
}

Future saveReview(storeReview StoreReview) async {
  final userRev = FirebaseFirestore.instance.collection("Reviews").doc();

  StoreReview.id = userRev.id;

  final json = StoreReview.toJson();
  await userRev.set(json);
}

class storeReview {
  String id;
  final String resName;
  final String resRev;
  final double resRating;
  final String revDate;



  storeReview({
    this.id = '',
    required this.resName,
    required this.resRev,
    required this.resRating,
    required this.revDate,

  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'resName': resName,
        'resRev': resRev,
        'resRating' : resRating,
        'revDate': revDate,
      };

  static storeReview fromJson(Map<String, dynamic> json) => storeReview(
        id: json['id'],
        resName: json['resName'],
        resRev: json['resRev'],
        resRating: json['resRating'],
        revDate: json['revDate'],
      );
}
