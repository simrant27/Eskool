import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../CustomUi/own_msg.dart';
import '../CustomUi/replycard.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {super.key, required this.chatModel, required this.sourceChat});
  final ChatModel chatModel;
  final ChatModel sourceChat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  late IO.Socket socket;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    connect();
    loadMessages(); // Load messages from MongoDB on initialization
  }

  void connect() {
    socket = IO.io("http://192.168.18.56:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();

    socket.onConnect((data) {
      print('Connected to myNamespace');
      print("connected");

      // Emit signin with the current user's ID
      socket.emit("signin", widget.sourceChat.id);

      // Remove any existing message listener to prevent duplicates
      socket.off("message");

      // Add new listener for incoming messages
      socket.on("message", (msg) {
        print("Message received: $msg");
        if (mounted) {
          setState(() {
            // Add the received message to the list
            messages.add(MessageModel(
              type:
                  "destination", // Assuming "destination" for received messages
              message: msg["message"],
              time: DateTime.now().toString().substring(10, 16),
            ));
          });

          Future.delayed(Duration.zero, () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        }
      });
    });

    // Listen for disconnection
    socket.onDisconnect((_) {
      print("Disconnected from socket");
    });
  }

  Future loadMessages() async {
    final response = await http.get(Uri.parse(
        'http://192.168.18.56:5000/messages/senderId=${widget.sourceChat.id}?receiverId=${widget.chatModel.id}'));

    if (response.statusCode == 200) {
      List<dynamic> messageList = jsonDecode(response.body);
      setState(() {
        messages =
            messageList.map((msg) => MessageModel.fromJson(msg)).toList();
        print("messages $messages");
      });
    }
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});

    // Save message to MongoDB
    http.post(
      Uri.parse('http://192.168.18.56:5000/messages'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'message': message,
        'type': 'source',
        'time': DateTime.now().toString().substring(10, 16),
        'sourceId': sourceId,
        'targetId': targetId,
      }),
    );
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
    );

    if (mounted) {
      setState(() {
        messages.add(messageModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        leadingWidth: 100,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.arrow_back, size: 24),
              CircleAvatar(
                child: widget.chatModel.isGroup!
                    ? Icon(Icons.group)
                    : Icon(Icons.person),
                radius: 25,
              ),
            ],
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatModel.name, style: TextStyle(fontSize: 18.5)),
            Text("Last seen at 18:06", style: TextStyle(fontSize: 13))
          ],
        ),
      ),
      body: FutureBuilder(
        future: loadMessages(), // Call the fetch function
        builder: (context, snapshot) {
          // Check for connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Show error message
          } else if (snapshot.hasData) {
            // Get the fetched data
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(height: 70);
                        }
                        if (messages[index].type == "source") {
                          return OwnMsgCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return Replycard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      margin: EdgeInsets.only(left: 10, right: 2, bottom: 10),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Attach file functionality can go here
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomsheet(),
                                  );
                                },
                                icon: Icon(Icons.attach_file),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Camera functionality can go here
                                },
                                icon: Icon(Icons.camera_alt),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CircleAvatar(
                        radius: 25,
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                            sendMessage(
                                _controller.text,
                                widget.sourceChat.id.toString(),
                                widget.chatModel.id.toString());
                            _controller.clear();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ); // Show no data message
          }
        },
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Column(
        children: [
          // Add bottom sheet content here
          ListTile(
            leading: Icon(Icons.insert_photo),
            title: Text("Photo"),
          ),
          ListTile(
            leading: Icon(Icons.file_copy),
            title: Text("File"),
          ),
        ],
      ),
    );
  }
}
