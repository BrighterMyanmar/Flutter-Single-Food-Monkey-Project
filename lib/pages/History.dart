import 'package:app/pages/Chat.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your History"),
          centerTitle: true,
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Chat()));
                },
                child: Icon(Icons.chat)),
            SizedBox(width: 20),
          ],
        ),
        body: ListView.builder(
            itemCount: Constants.orders.length,
            itemBuilder: (context, pindex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                color: Constants.normal,
                child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("02-02-2022",
                            style: TextStyle(
                                color: Constants.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        RaisedButton(
                          onPressed: () {},
                          color: Constants.normal,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text("17500 Ks",
                              style: TextStyle(
                                  color: Constants.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        )
                      ],
                    ),
                    children: [
                      ...List.generate(
                          Constants.orders[pindex].length,
                          (index) => _buildHistoryCard(
                              Constants.orders[pindex][index]))
                    ]),
              );
            }));
  }

  Container _buildHistoryCard(String name) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            color: Constants.accent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                    Constants.sampleImage,
                    width: 80,
                    height: 80),
                Column(
                  children: [
                    Text(name,
                        style: TextStyle(
                            color: Constants.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    Text("3 * 3500",
                        style: TextStyle(
                            color: Constants.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))
                  ],
                ),
                RaisedButton(
                  onPressed: () {},
                  color: Constants.normal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text("17500",
                      style: TextStyle(
                          color: Constants.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                )
              ],
            )),
      ),
    );
  }
}
