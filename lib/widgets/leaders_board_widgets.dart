import 'package:flutter/material.dart';

///
///this is for the declaration of the leaders board widget
///

//ignore:camel_case_types
class leadersBoardTitleWidget extends StatelessWidget {
  final String title;
  const leadersBoardTitleWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
    );
  }
}

///leadersBoard data head
//ignore:camel_case_types
class leadersBoardeHeadsWidget extends StatelessWidget {
  const leadersBoardeHeadsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 0.3 * width,
              child: const singleHeadWidget(head: "Position")),
          SizedBox(
              width: 0.3 * width, child: const singleHeadWidget(head: "Name")),
          SizedBox(
              width: 0.3 * width,
              child: const singleHeadWidget(head: "Amount")),
        ],
      );
    });
  } 
}

//ignore:camel_case_types
class singleHeadWidget extends StatelessWidget {
  final String head;
  const singleHeadWidget({required this.head, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.red,
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        color: Colors.white,
        constraints: const BoxConstraints.expand(),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
            ),
            Text(
              head,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

///this is for holding up the leadersboard list
///
//ignore:camel_case_types
class leadersBoardListWidget extends StatelessWidget {
  final String name;
  final String amount;
  final int position;
  const leadersBoardListWidget(
      {required this.name,
      required this.amount,
      required this.position,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          format(position),
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          name,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          amount,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  String format(int pos) {
    if (pos > 9) {
      if (pos > 99) {
        return "#$pos";
      } else {
        return "#0$pos";
      }
    }
    return "#00$pos";
  }
}
