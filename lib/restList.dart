import 'dart:convert';

import 'package:eatsafeproject/favorites/favList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'frontPage.dart';
import 'package:maps_launcher/maps_launcher.dart';



class SearchApi extends StatefulWidget {
  const SearchApi({Key? key}) : super(key: key);

  @override
  State<SearchApi> createState() => _SearchApiState();
}

class _SearchApiState extends State<SearchApi> {


  TextEditingController editingController = TextEditingController();
  List users = [];
  List restnames=<String>[];
  List lats=<double>[];
  List long=<double>[];
  bool isLoading = false;
  List items=<String>[];


  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("http://www.qrestaurant.acfs.go.th/webapp/api/shop.php?secret=B%E0%B8%81V%E0%B8%AEd%E0%B8%9ABEwq%E0%B8%A0QR89%E0%B8%9E%E0%B8%949L%E0%B8%AD%E0%B8%A24%E0%B8%A24%E0%B8%84%E0%B8%A9%E0%B8%A35%E0%B8%81V%E0%B8%A3i");
    var response = await http.get(url);
    if(response.statusCode == 200){
      var items = json.decode(utf8.decode(response.bodyBytes))['data'];
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      users = [];
      isLoading = false;
    }
    for(var user in users){
      restnames.add(user["rest_name"]);
      lats.add(double.parse(user["latitude"]));
      long.add(double.parse(user["longitude"]));
    }
    items.addAll(restnames);
  }
  void filterSearchResults(String query) {
    List dummySearchList = <String>[];
    dummySearchList.addAll(restnames);
    if(query.isNotEmpty) {
      List dummyListData = <String>[];
      for (String item in dummySearchList) {
        if(item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(restnames);
      });
    }
  }


  Widget getCard(restName,latitude,longitude){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      color: Color(0xE6131619),
      elevation: 1.5,
      child:ListTile(
        leading:Icon(
              Icons.restaurant,
              color: Color(0xFF40ADF0),
              size: 40,
            ),
        title: Text(restName,style: TextStyle(fontSize: 20,color: Colors.white, fontFamily: 'Kanit' , fontWeight: FontWeight.bold)),
        trailing: IconButton(
          icon:Icon(
                Icons.pin_drop_outlined,
                color: Color(0xFF40ADF0),
                size: 40,
              ),
            onPressed: () => MapsLauncher.launchCoordinates(
                latitude,longitude)
        ),
      ),

    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Restraunts"),
        backgroundColor: Color(0xE6131619),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => frontPage()),
            );

          },
        ),
        actions: <Widget> [
          IconButton(
            icon:  Icon(
              Icons.star,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => favoriteList()),
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  label: Text("Search", style: TextStyle(color: Colors.white),),
                  hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white,),
                  fillColor: Colors.white,
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
              ),
            ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return getCard( items[index],lats[index], long[index]
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}