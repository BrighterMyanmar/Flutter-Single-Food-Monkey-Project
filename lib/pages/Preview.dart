import 'package:app/models/Product.dart';
import 'package:app/pages/Detail.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'dart:math' as math;

class Preview extends StatefulWidget {
  final Product? product;
  const Preview({Key? key, this.product}) : super(key: key);

  @override
  _PreviewState createState() => _PreviewState(product);
}

class _PreviewState extends State<Preview> {
  Product? product;
  _PreviewState(this.product);
  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Preview"),
          actions: [Constants.getShoppingCardWidget(context, Colors.white)],
        ),
        body: Stack(
          children: [
            CustomPaint(
              painter: ArcPainter(msize),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Text(product?.name ?? "",
                      style: Constants.getTitleTextStyle()),
                ),
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
                SizedBox(height: 40),
                _buildRichText("Price", "\t\t\t\t3500 Kyats"),
                SizedBox(height: 40),
                _buildRichText("Size", "\t\t\t\tLarge Size"),
                SizedBox(height: 40),
                _buildRichText("Promo", "\t\t\t\tCoca Cola"),
                SizedBox(height: 40),
                Row(
                  children: [
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            Constants.addToCart(product);
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Constants.normal,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 45,
                                ),
                                Text("Buy Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ]),
                        )),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(product: product)));
                        },
                        child: Container(
                            height: 60,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Constants.normal,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text("Detail",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )))
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget _buildRichText(text1, text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "$text1\n",
            style: TextStyle(
                color: Constants.accent, fontSize: 35, fontFamily: "English")),
        TextSpan(
            text: "$text2",
            style: TextStyle(
                color: Constants.normal, fontSize: 18, fontFamily: "English")),
      ])),
    );
  }
}

class ArcPainter extends CustomPainter {
  var mediaSize;
  ArcPainter(this.mediaSize);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Constants.secondary;

    final rect =
        Rect.fromLTRB(-550, 100, mediaSize.width + 5, mediaSize.height + 500);

    final startAngle = -degreeToRadian(100);
    final sweepAngle = degreeToRadian(300);
    final useCenter = false;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  degreeToRadian(value) {
    return value * (math.pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
