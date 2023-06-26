import 'package:flutter/material.dart';
import 'package:propup/widgets/leaders_board_widgets.dart';

///
///this is where the real leaders board code shall be declared
///
//ignore:camel_case_types
class leadersBoardScreen extends StatelessWidget {
  final bool receivers;
  const leadersBoardScreen({required this.receivers, super.key});

  final names = const <String>[
    "Avax T",
    "templer Y",
    "Avax T",
    "Avax T",
    "James bowl",
    "Averter",
    "Anitar k",
    "Avax T",
    "Jacob C",
    "Wadika K",
    "Kevin B",
  ];
  final amounts = const <String>[
    "50,878",
    "234",
    "45,452",
    "43,241",
    "1,424",
    "89,456",
    "33,432",
    "534,432",
    "6,367,467",
    "76,784",
    "235",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: LayoutBuilder(builder: (context, dimensions) {
                  return Column(
                    children: [
                      leadersBoardTitleWidget(
                          title: receivers ? "Recievers" : "Donors"),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        constraints: const BoxConstraints.expand(height: 60),
                        child: const leadersBoardeHeadsWidget(),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: names.length,
                              itemBuilder: (constext, index) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: leadersBoardListWidget(
                                      name: names[index],
                                      amount: amounts[index],
                                      position: index,
                                    ),
                                  )))
                    ],
                  );
                }))));
  }
}
