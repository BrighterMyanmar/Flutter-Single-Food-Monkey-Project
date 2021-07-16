import 'dart:convert';
import 'dart:io';

import 'package:app/models/Message.dart';
import 'package:app/models/MsgRes.dart';
import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> chats = [];
  final picker = ImagePicker();
  File? _image;
  final _msgInputController = TextEditingController();
  ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 50.0);

  invikeSocket() {
    Constants.socket?.emit('load');
    Constants.socket?.on("message", (data) {
      print("New Message");
      Message msg = Message.fromJson(data);
      chats.add(msg);
      setState(() {
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 450,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn);
      });
    });
    Constants.socket?.on("messages", (data) {
      List lisy = data as List;
      chats = lisy.map((e) => Message.fromJson(e)).toList();
      setState(() {
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 450,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn);
      });
    });
  }

  _emitMessage(msg, type) {
    var sendMsg = new Map();
    sendMsg["from"] = Constants.user?.id;
    sendMsg["to"] = Constants.shopId;
    sendMsg["msg"] = msg;
    sendMsg["type"] = type;
    Constants.socket?.emit("message", sendMsg);
  }

  @override
  void initState() {
    super.initState();
    invikeSocket();
  }

  @override
  Widget build(BuildContext context) {
    var msize = (MediaQuery.of(context).size.width / 3) * 2;
    return Scaffold(
        appBar: AppBar(title: Text("Chat")),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chats.length,
                  itemBuilder: (context, index) =>
                      chats[index].from?.name == Constants.user?.name
                          ? _leftUser(msize, chats[index])
                          : _rightUser(msize, chats[index]))),
          Container(
            height: 40,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Constants.normal),
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      await getImage();
                    },
                    child: Icon(Icons.file_copy)),
                Expanded(
                  child: TextFormField(
                    controller: _msgInputController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.normal))),
                  ),
                ),
                InkWell(
                    onTap: () {
                      var mesg = _msgInputController.text;
                      _emitMessage(mesg, "text");
                    },
                    child: Icon(Icons.send)),
              ],
            ),
          )
        ]));
  }

  uploadImageNow() async {
    var postUri = Uri.parse(Constants.GALLERY_URL);
    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath("photo", _image?.path ?? "");
    request.files.add(multipartFile);
    request.headers.addAll(Constants.tokenHeader);
    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        var resData = jsonDecode(value);
        MsgRes msgRes = MsgRes.fromJson(resData['result']);
        _emitMessage(msgRes.link, "image");
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile?.path ?? "");
      uploadImageNow();
    });
  }

  Widget _leftUser(msize, Message chat) {
    return chat.type == "text"
        ? _buildLeftChatBox(msize, chat)
        : _buildLeftImage(msize, chat.msg);
  }

  Widget _rightUser(msize, chat) {
    return chat.type == "text"
        ? _buildRightChatBox(msize, chat)
        : _buildRightImage(msize, chat.msg);
  }

  Widget _buildLeftImage(msize, var image) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: msize,
          decoration: BoxDecoration(
              color: Constants.normal,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Image.network(Constants.changeImageLink(image)),
        ),
      ],
    );
  }

  Widget _buildRightImage(msize, var image) {
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

  Widget _buildLeftChatBox(msize, Message chat) {
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
              Text(chat.from?.name ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(chat.msg ?? "", style: TextStyle(color: Constants.normal)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(chat.created ?? "",
                      style: TextStyle(color: Constants.primary)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightChatBox(msize, Message chat) {
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
              Text(chat.from?.name ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(chat.msg ?? "", style: TextStyle(color: Constants.normal)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(chat.created ?? "",
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
