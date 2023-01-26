
import 'package:eatsafeproject/reviews/listReviewPage.dart';
import 'package:eatsafeproject/reviews/searchReviews.dart';
import 'package:flutter/material.dart';
import 'newreview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class searches extends StatelessWidget {
  searches({Key? key,
    required this.queries
  }) : super(key: key);

  String queries;

  Stream<List<storeReview>> readRev() => FirebaseFirestore.instance
      .collection('Reviews').where("resName", isEqualTo: queries)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => storeReview.fromJson(doc.data())).toList()
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            title:
            Text('Search results for: ${queries}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor:Color(0xE6131619),
            automaticallyImplyLeading: false,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => reviewsList()),
                );
              },
            ),
            actions: <Widget> [
              IconButton(
                icon:  Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => searchReviews()),
                  );
                },
              )
            ],
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => addReview()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('New'),
            backgroundColor: Color(0xFF42BEA5),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              StreamBuilder(
                stream: readRev(),
                builder: (context,AsyncSnapshot<List<storeReview>>snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  }
                  else if (snapshot.hasData){
                    final res = snapshot.data!;
                    return ListView(
                      children: res.map(buildRev).toList(),
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
          ),
        )
    );
  }

  Widget buildRev(storeReview StoreReview) => ListTile(
    leading: Container(
        width: 50,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green[700],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('${StoreReview.resRating}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(width: 2),
          Icon(
            Icons.star,
            color: Colors.white,
            size: 18.0,
          ),
        ])),
    title: Text(StoreReview.resName,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15)),
    subtitle: Text('\n${StoreReview.resRev}\n \n${StoreReview.revDate}',
        style: TextStyle(color: Colors.white, fontSize: 12)),
    isThreeLine: true,
  );
}
