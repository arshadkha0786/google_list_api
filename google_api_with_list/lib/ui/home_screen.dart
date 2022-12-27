import 'package:flutter/material.dart';
import 'package:google_api_with_list/comman/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiUrl = "https://randomuser.me/api/?results=10";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['results'];
  }

  String _name(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String _location(dynamic user) {
    return user['location']['country'];
  }

  String _age(Map<dynamic, dynamic> user) {
    return "Age: " + user['dob']['age'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstString.dashboard),
        ),
        body: FutureBuilder<List<dynamic>>(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < snapshot.data.length; i++)
                        Container(
                          padding: const EdgeInsets.all(9.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      snapshot.data[i]['picture']['large'])),
                              Column(
                                children: [
                                  Text(_name(snapshot.data[i])),
                                  Text(_location(snapshot.data[i])),
                                ],
                              ),
                              Text(_age(snapshot.data[i]))
                            ],
                          ),
                        ),
                      const Divider(height: 1),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

//we can also use this kind of code for list inside the column
/*class HomeScreen extends StatelessWidget {
  final List<dynamic> productMap = [
    {"numOfDay": 0, "amount": 814.75},
    {"numOfDay": 1, "amount": 0.00},
    {"numOfDay": 2, "amount": 0.00},
    {"numOfDay": 3, "amount": 0.00},
    {"numOfDay": 4, "amount": 0.00},
    {"numOfDay": 5, "amount": 0.00},
    {"numOfDay": 6, "amount": 0.00},
    {"numOfDay": 7, "amount": 0.00},
    {"numOfDay": 8, "amount": 0.00},
    {"numOfDay": 9, "amount": 0.00},
    {"numOfDay": 10, "amount": 0.00},
    {"numOfDay": 11, "amount": 0.00},
    {"numOfDay": 12, "amount": 0.00}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("No o Day"),
            Text("Amount (RM)"),
          ]),
        _getBody(),
        ]),
      ),
    );
  }

  _getBody() {
    return productMap.map(
        (e) => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(e["numOfDay"].toString()),
              Text(e["amount"].toString()),
            ]));
  }
}*/
