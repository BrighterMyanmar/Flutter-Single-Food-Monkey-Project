import 'package:app/models/Category.dart';
import 'package:app/pages/Chat.dart';
import 'package:app/pages/ProductPage.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  if (Constants.user == null) {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    Navigator.pushNamed(context, "/chat");
                  }
                },
                child: Icon(Icons.chat)),
            SizedBox(width: 20),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleText(context, "Tags"),
            Container(
              height: 150,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  loadName: Constants.tags[index].name,
                                  type: "tag")));
                    },
                    child: new Image.network(
                      Constants.tags[index].image ?? "",
                      fit: BoxFit.contain,
                    ),
                  );
                },
                itemCount: Constants.tags.length,
                pagination: new SwiperPagination(),
                control: new SwiperControl(),
              ),
            ),
            _buildTitleText(context, "Categories"),
            GridView.builder(
                shrinkWrap: true,
                itemCount: Constants.cats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0),
                itemBuilder: (context, index) =>
                    _buildCategory(context, Constants.cats[index]))
          ],
        ));
  }

  Widget _buildCategory(BuildContext context, Category cat) {
    return Container(
      child: Card(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    // Navigator.pushNamed(context, "/products");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                  loadName: cat.name,
                                  type: "category",
                                )));
                  });
                },
                child: Image.network(cat.image ?? "")),
            Text(cat.name ?? "")
          ],
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context, String text) {
    return SafeArea(
      child: Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.5)),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Constants.normal))),
    );
  }
}
