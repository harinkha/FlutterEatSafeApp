import 'package:eatsafeproject/authentication/loginScreen.dart';
import 'package:eatsafeproject/restList.dart';
import 'package:flutter/material.dart';
import 'reviews/listReviewPage.dart';
import 'restList.dart';



class frontPage extends StatefulWidget {
  const frontPage({Key? key}) : super(key: key);

  @override
  State<frontPage> createState() => _frontPageState();
}

class _frontPageState extends State<frontPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar:AppBar(
            backgroundColor: Colors.black,
            leading: new IconButton(
            icon: new Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
              },
             ),
          ),
          backgroundColor: Colors.black,
            body: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(70, 50, 0, 0),
                          child: Image.asset(
                            'assets/dish.png',
                            width: 240,
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 50),
                              child: Text('EAT SAFE',
                              style: TextStyle(
                                color: Colors.white,
                              fontFamily: 'Rubik',
                                  fontSize: 60,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,),)
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(80, 2, 0, 20),
                                  child: TextButton(onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SearchApi()),
                                    );

                                  },
                                    child: Text("Safe Restaurants", style: TextStyle(fontSize: 30, color: Colors.white),),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF42BEA5),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(80, 10, 0, 0),
                                  child: TextButton(onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => reviewsList()),
                                    );
                                  },
                                    child: Text("        Reviews        ", style: TextStyle(fontSize: 30, color: Color(0xFF42BEA5)),),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                                    ),
                                  ),
                                )
                              ],
                            ),

                          ],
                        )
                      ),
                    )
                  ],
                ),

            )));
  }
}
