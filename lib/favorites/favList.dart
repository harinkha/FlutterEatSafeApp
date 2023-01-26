import 'package:eatsafeproject/frontPage.dart';
import 'package:eatsafeproject/favorites/newFav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../restList.dart';
import 'newFav.dart';

class favoriteList extends StatefulWidget {
  const favoriteList({Key? key}) : super(key: key);

  @override
  State<favoriteList> createState() => _favoriteListState();
}

class _favoriteListState extends State<favoriteList> {
  final favorites = FirebaseFirestore.instance
      .collection("userData")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("favorites");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xE6131619),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchApi()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => favRestaurant()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New'),
        backgroundColor: Color(0xFF42BEA5),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: favorites.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final res = snapshot.data!;
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot snap = snapshot.data!.docs[index];
                      return buildFav(snap["resName"], snap);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    ));
  }



  buildFav(String restaurant, DocumentSnapshot snap) {
    return Column(
      children: [
        Container(
          height: 70,
          child: Card(
            color: Color(0xE6131619),
            child: ListTile(
              leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.star,
                    color: Color(0xFFFFCC33),
                    size: 40,
                  )),
              title: Text(restaurant,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              trailing: IconButton(
                icon:
                    new Icon(Icons.delete_forever_outlined, color: Colors.red),
                onPressed: () {
                  final delRes = FirebaseFirestore.instance
                      .collection("userData")
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection("favorites")
                      .doc(snap.id);
                  delRes.delete();
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
