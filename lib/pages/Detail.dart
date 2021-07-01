import 'package:app/models/Product.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class Detail extends StatefulWidget {
  final Product? product;
  const Detail({Key? key, this.product}) : super(key: key);

  @override
  _DetailState createState() => _DetailState(product);
}

class _DetailState extends State<Detail> {
  Product? product;
  _DetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
          actions: [Constants.getShoppingCardWidget(context, Colors.white)],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 150,
                child: Swiper(
                  index: 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      Constants.changeImageLink(product?.images?[index]),
                      fit: BoxFit.contain,
                    );
                  },
                  autoplay: true,
                  itemCount: product?.images?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  pagination:
                      SwiperPagination(alignment: Alignment.centerRight),
                  control: SwiperControl(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(product?.name ?? "",
                      style: Constants.getTitleTextStyle()),
                  Constants.getShoppingCardWidget(context, Colors.pinkAccent),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRichText("Price", "${product?.price} Ks"),
                  _buildRichText("Size", "${product?.size}"),
                  _buildRichText("Promo", "Coca Cola"),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(Constants.sampleText,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Constants.normal, fontSize: 16)),
              ),
              // Text(product?.desc ?? "")
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  border: TableBorder.all(color: Constants.normal),
                  children: [
                    TableRow(children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Feature",
                              style: TextStyle(
                                color: Constants.secondary,
                                fontSize: 18,
                              )),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Value",
                              style: TextStyle(
                                color: Constants.secondary,
                                fontSize: 18,
                              )),
                        ),
                      ),
                    ]),
                    _buildTableRow("Color", "Red"),
                    _buildTableRow("Size", "${product?.size}"),
                    _buildTableRow("Discount", "${product?.discount}"),
                    _buildTableRow("Color", "Red"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(Constants.sampleText,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Constants.normal, fontSize: 16)),
              ),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Warranty",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Constants.normal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Image.network(Constants.BASE_URL +
                    "/uploads/7_Day_Return_Warrranty_1625047825360.png"),
              ),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Delivery",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Constants.normal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Image.network(Constants.BASE_URL +
                    "/uploads/Daily_Delivery_1625048001786.png"),
              )
            ],
          ),
        ));
  }

  TableRow _buildTableRow(text1, text2) {
    return TableRow(children: [
      Center(
          child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(text1,
            style: TextStyle(color: Constants.normal, fontSize: 16)),
      )),
      Center(
          child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(text2,
            style: TextStyle(color: Constants.normal, fontSize: 16)),
      )),
    ]);
  }

  Widget _buildRichText(text1, text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "$text1\n",
            style: TextStyle(
                color: Constants.accent, fontSize: 25, fontFamily: "English")),
        TextSpan(
            text: "\t\t\t$text2",
            style: TextStyle(
                color: Constants.normal, fontSize: 16, fontFamily: "English")),
      ])),
    );
  }
}
