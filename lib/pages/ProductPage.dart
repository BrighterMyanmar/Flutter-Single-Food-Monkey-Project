import 'package:app/models/Product.dart';
import 'package:app/pages/Preview.dart';
import 'package:app/util/Api.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String? loadName, type;
  const ProductPage({Key? key, this.loadName, this.type}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(loadName, type);
}

class _ProductPageState extends State<ProductPage> {
  String? loadName, type;
  _ProductPageState(this.loadName, this.type);

  int pageNo = 0;
  List<Product> products = [];
  bool isLoading = false;

  loadProduct() async {
    setState(() {
      isLoading = true;
    });
    List<Product> ps = await Api.getPaginatedProducts(pageNo: pageNo);
    setState(() {
      products.addAll(ps);
      pageNo++;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(loadName ?? "Products"),
        ),
        body: Column(children: [
          Text("Title Bar"),
          Expanded(
              child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                loadProduct();
              }
              return false;
            },
            child: _buildProductGrid(),
          )),
          Container(
              child:
                  Center(child: isLoading ? CircularProgressIndicator() : null))
        ]));
  }

  GridView _buildProductGrid() {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => _buildProductCard(products[index]),
    );
  }

  Column _buildProductCard(Product product) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Image.network(Constants.changeImageLink(product.images?[0])),
      ),
      InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Preview(product: product)));
          },
          child: Text(product.name ?? "")),
      Text("${product.price}",
          style: TextStyle(fontWeight: FontWeight.bold, height: 1.2))
    ]);
  }
}
