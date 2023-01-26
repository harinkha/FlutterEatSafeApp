import 'dart:convert';
import 'dart:ui';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eatsafeproject/favorites/bookmarks.dart';
import 'package:eatsafeproject/favorites/favList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class favRestaurant extends StatefulWidget {
  const favRestaurant({Key? key}) : super(key: key);

  @override
  State<favRestaurant> createState() => _favRestaurantState();
}

class _favRestaurantState extends State<favRestaurant> {
  final db = FirebaseFirestore.instance;
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

  String savename = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                                    'Favorite Restaurant',
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
                                      'Add a restaunrant that has caught your eye.',
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
                                      hintText: 'Choose Restaurant',
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
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: TextButton(
                                onPressed: () {
                                  final bookmark = Bookmark(savename);
                                  saveResBook(bookmark);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => favoriteList()),
                                  );
                                },
                                child: Text(
                                  "  Add to Favorites  ",
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
                                        builder: (context) => favoriteList()),
                                  );
                                },
                                child: Text(
                                  "          Cancel          ",
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
                ]))
              ],
            )));
  }

  Future saveResBook(Bookmark bookmark) async {
    final uid = await FirebaseAuth.instance.currentUser?.uid;
    await db
        .collection("userData")
        .doc(uid)
        .collection("favorites")
        .add(bookmark.toJson());
  }
}
