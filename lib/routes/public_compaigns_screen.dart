import 'package:flutter/material.dart';
import 'package:propup/state_managers/public_compaigns_state_notifier.dart';
import 'package:propup/widgets/public_compaigns_screen_widgets.dart';
import 'package:provider/provider.dart';

class publicCompaignScreen extends StatelessWidget {
  const publicCompaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 92, 181),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Public compaigns",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ChangeNotifierProvider<publicCompaignsStateNotifier>(
        create: (context) => publicCompaignsStateNotifier(),
        builder: (context, child) {
          return SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  children: [
                    const Card(
                      elevation: 5,
                      
                        child: Padding(padding: EdgeInsets.all(5) , child: Text(
                            "Welcome to the propup public support compaings help who ever you want or that you know.",
                            textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, ),))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "All Compaigns",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<publicCompaignsStateNotifier>(
                        builder: (_, value, child) {
                      return SegmentedButton<int>(
                        showSelectedIcon: false,
                        segments: const [
                          ButtonSegment(label: Text("FundRaises"), value: 0),
                          ButtonSegment(label: Text("Loans"), value: 1),
                        ],
                        selected: {value.currentIndex},
                        onSelectionChanged: (selections) {
                          value.setCurrentIndex(index: selections.first);
                        },
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(child: Consumer<publicCompaignsStateNotifier>(
                      builder: (_, value, child) {
                        return (value.currentIndex == 0)
                            ? const publicCompaignWidget(isLoans: false)
                            : const publicLoansCompaignWidget(isLoans: true);
                      },
                    ))
                  ],
                )),
          );
        },
      ),
    );
  }
}
