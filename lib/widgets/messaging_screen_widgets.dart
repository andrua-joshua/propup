import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:propup/routes.dart';

///
///all widgets
///

//ignore:camel_case_types
class messagingTopWidget extends StatelessWidget {
  final String image;
  final String name;
  const messagingTopWidget(
      {required this.name, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 10,
      onTap: () =>
          Navigator.pushNamed(context, RouteGenerator.friendprofilescreen),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: const Color.fromARGB(255, 207, 206, 206),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage(image),
        ),
      ),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

///
///this is for the typing and sending of the messages
///
//ignore:camel_case_types
class sendingWidget extends StatefulWidget {
  const sendingWidget({super.key});

  @override
  _sendingWidgetState createState() => _sendingWidgetState();
}

//ignore:camel_case_types
class _sendingWidgetState extends State<sendingWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        padding: const EdgeInsets.all(3),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              //maxLines: 5,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "enter message"),
            )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
