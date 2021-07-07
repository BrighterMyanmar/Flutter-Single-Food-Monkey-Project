import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, String>> chats = [
    {
      "from": "Mg Mg",
      "to": "Aung Aung",
      "msg": "How are you?",
      "type": "text",
      "created": "20-02-2022"
    },
    {
      "from": "Aung Aung",
      "to": "Mg Mg",
      "msg": Constants.sampleText,
      "type": "text",
      "created": "20-02-2022"
    },
    {
      "from": "Mg Mg",
      "to": "Aung Aung",
      "msg": Constants.sampleImage,
      "type": "image",
      "created": "20-02-2022"
    },
    {
      "from": "Aung Aung",
      "to": "Mg Mg",
      "msg": Constants.sampleImage2,
      "type": "image",
      "created": "20-02-2022"
    },
    {
      "from": "Mg Mg",
      "to": "Aung Aung",
      "msg": Constants.sampleText,
      "type": "text",
      "created": "20-02-2022"
    },
    {
      "from": "Aung Aung",
      "to": "Mg Mg",
      "msg": "Good",
      "type": "text",
      "created": "20-02-2022"
    },
    {
      "from": "Mg Mg",
      "to": "Aung Aung",
      "msg": Constants.sampleImage,
      "type": "image",
      "created": "20-02-2022"
    },
    {
      "from": "Aung Aung",
      "to": "Mg Mg",
      "msg": Constants.sampleImage2,
      "type": "image",
      "created": "20-02-2022"
    }
  ];
  @override
  Widget build(BuildContext context) {
    var msize = (MediaQuery.of(context).size.width / 3) * 2;
    return Scaffold(
        appBar: AppBar(title: Text("Chat")),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) =>
                      chats[index]["from"] == "Mg Mg"
                          ? _leftUser(msize, chats[index])
                          : _rightUser(msize, chats[index]))),
          Container(
            height: 40,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Constants.normal),
            child: Row(
              children: [
                Icon(Icons.file_copy),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.normal))),
                  ),
                ),
                Icon(Icons.send),
              ],
            ),
          )
        ]));
  }

  Widget _leftUser(msize, chat) {
    return chat["type"] == "text"
        ? _buildLeftChatBox(msize, chat)
        : _buildLeftImage(msize, chat["msg"]);
  }

  Widget _rightUser(msize, chat) {
    return chat["type"] == "text"
        ? _buildRightChatBox(msize, chat)
        : _buildRightImage(msize, chat["msg"]);
  }

  Widget _buildLeftImage(msize, String image) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: msize,
          decoration: BoxDecoration(
              color: Constants.normal,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Image.network(image),
        ),
      ],
    );
  }

  Widget _buildRightImage(msize, String image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: msize,
          decoration: BoxDecoration(
              color: Constants.darkGrey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Image.network(image),
        ),
      ],
    );
  }

  Widget _buildLeftChatBox(msize, Map<String, String> chat) {
    return Row(
      children: [
        Container(
          width: msize,
          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Constants.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chat["from"] ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(chat["msg"] ?? "",
                  style: TextStyle(color: Constants.normal)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(chat["created"] ?? "",
                      style: TextStyle(color: Constants.primary)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightChatBox(msize, Map<String, String> chat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: msize,
          padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Constants.accent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(10),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(chat["from"] ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(chat["msg"] ?? "",
                  style: TextStyle(color: Constants.normal)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(chat["created"] ?? "",
                      style: TextStyle(color: Constants.primary)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
