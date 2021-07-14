import 'package:app/models/HistoryModel.dart';
import 'package:app/pages/Chat.dart';
import 'package:app/util/Api.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryModel> hm = [];
  loadHistoryProduct() async {
    List<HistoryModel> hh = await Api.getMyOrders();
    setState(() {
      hm = hh;
      print(hm.length);
    });
  }

  @override
  void initState() {
    super.initState();
    loadHistoryProduct();
  }

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
            itemCount: hm.length,
            itemBuilder: (context, pindex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                color: Constants.normal,
                child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(hm[pindex].created ?? "",
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
                          child: Text(hm[pindex].total.toString(),
                              style: TextStyle(
                                  color: Constants.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        )
                      ],
                    ),
                    children: [
                      ...List.generate(
                          hm[pindex].items?.length ?? 0,
                          (index) =>
                              _buildHistoryCard(hm[pindex].items?[index]))
                    ]),
              );
            }));
  }

  Container _buildHistoryCard(var item) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            color: Constants.accent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(Constants.changeImageLink(item.images[0]),
                    width: 80, height: 80),
                Column(
                  children: [
                    Text(item.name,
                        style: TextStyle(
                            color: Constants.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    Text("${item.count} * ${item.price}",
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
                  child: Text("${item.count * item.price}",
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
