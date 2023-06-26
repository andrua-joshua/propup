import 'package:flutter/material.dart';
import 'package:propup/widgets/fundraise_screen_widgets.dart';

///
///this is where the transaction screen widget  will be defined
///
//ignore: camel_case_types
class transactionsScreen extends StatelessWidget {
  const transactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: true,
            centerTitle: true,
            expandedHeight: 120,
            collapsedHeight: 80,
            title: Text(
              "Transactions",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "July 01, 2022",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
          SliverList.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ListTile(
                    leading: Card(
                        elevation: 7,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          padding: const EdgeInsets.all(7),
                          child: const Icon(
                            Icons.fingerprint_sharp,
                            color: Colors.grey,
                          ),
                        )),
                    title: Text(
                      (index % 2 == 0) ? "Bank Transfer" : "Borrowed",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      (index % 2 == 0) ? "Deposite" : "You borrowed john",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing:
                        transactionDataWidget(isBorrowed: (index % 2 == 0)),
                  ))
        ],
      ),
    );
  }
}
