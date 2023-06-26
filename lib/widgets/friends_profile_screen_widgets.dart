import 'package:flutter/material.dart';

///
///this is where all the custom widgets of the friends screen will be defined
///

///the one for holding the location
//ignore: camel_case_types
class locationWidget extends StatelessWidget {
  final String location;
  const locationWidget({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.place,
          color: Colors.grey,
        ),
        Text(
          location,
          style: const TextStyle(color: Colors.grey, fontSize: 22),
        )
      ],
    );
  }
}

///
///this is for expression of moodes towards the friend
///
//ignore: camel_case_types
class expressionsWidget extends StatelessWidget {
  const expressionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.purple),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: const Icon(
              Icons.thumb_down,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "1.6k",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "FRIENDS",
                style: TextStyle(
                    color: Colors.lightBlue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.green),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: const Icon(
              Icons.thumb_up,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

///
///this is to show the recieved and donated catch\
///
//ignore: camel_case_types
class transfersWidget extends StatelessWidget {
  const transfersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Column(
            children: [
              Text(
                "\$489",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              Text(
                "Recieved",
                style: TextStyle(color: Colors.purple, fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Text(
                "\$3.7k",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              Text(
                "Donated",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
