import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where all the custom widgets of the edit profile screen will be created from
///

//ignore:camel_case_types
class profilePicRowWidget extends StatelessWidget {
  const profilePicRowWidget({super.key});

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          profilePicWidget(),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            "Enter your name and add an optional profile picture",
            style: TextStyle(color: Colors.grey),
          ))
        ],
      );
}

//ignore:camel_case_types
class profilePicWidget extends StatelessWidget {
  const profilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: 6,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                ),
              ),
            )),
        TextButton(
            onPressed: () {},
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ))
      ],
    );
  }
}

///
///this is for the full name entry
//ignore:camel_case_types
class fullNameRowWidget extends StatefulWidget {
  const fullNameRowWidget({super.key});

  @override
  _fullNameRowWidgetState createState() => _fullNameRowWidgetState();
}

//ignore:camel_case_types
class _fullNameRowWidgetState extends State<fullNameRowWidget> {
  late final firstNameController;
  late final lastNameController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
              color: Colors.white,
              elevation: 7,
              child: Container(
                width: 0.45 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextFormField(
                    controller: firstNameController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: "First name",
                        suffixIcon: Icon(Icons.cancel_rounded)),
                  ),
                ),
              )),
          Card(
              color: Colors.white,
              elevation: 7,
              child: Container(
                width: 0.45 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextFormField(
                    controller: lastNameController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: "Last name",
                        suffixIcon: Icon(Icons.cancel_rounded)),
                  ),
                ),
              ))
        ],
      );
    });
  }
}

///
///for entering the distric or loaction of the user
///
//ignore:camel_case_types
class locationRowWidget extends StatefulWidget {
  const locationRowWidget({super.key});

  @override
  _locationRowWidgetState createState() => _locationRowWidgetState();
}

//ignore:camel_case_types
class _locationRowWidgetState extends State<locationRowWidget> {
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
      elevation: 6,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: TextFormField(
              controller: _controller,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: "District",
              )),
        ),
      ),
    );
  }
}

///
///for entering the distric or loaction of the user
///
//ignore:camel_case_types
class aboutRowWidget extends StatefulWidget {
  const aboutRowWidget({super.key});

  @override
  _aboutRowWidgetState createState() => _aboutRowWidgetState();
}

//ignore:camel_case_types
class _aboutRowWidgetState extends State<aboutRowWidget> {
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
      elevation: 6,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: TextFormField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Description",
              )),
        ),
      ),
    );
  }
}

//ignore:camel_case_types
class saveBtnWidget extends StatelessWidget {
  const saveBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: TextButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.blue),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Center(
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}

//ignore:camel_case_types
class mySummaryWidget extends StatelessWidget {
  const mySummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("122",
                  style: TextStyle(
                      color: Color.fromARGB(255, 9, 14, 17),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                "followers",
                style: TextStyle(),
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("67",
                  style: TextStyle(
                      color: Color.fromARGB(255, 9, 14, 17),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                "friends",
                style: TextStyle(),
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("122",
                  style: TextStyle(
                      color: Color.fromARGB(255, 9, 14, 17),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                "following",
                style: TextStyle(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

///
///editing options row
///
//ignore:camel_case_types
class editOptionsWidget extends StatelessWidget {
  const editOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 27, 48, 66)),
          child: TextButton(
              onPressed: () => Navigator.pushNamed(
                  context, RouteGenerator.editprofilescreen),
              child: const Text(
                "Edit profile",
                style: TextStyle(color: Colors.white),
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 27, 48, 66)),
          child: TextButton(
              onPressed: ()=> Navigator.pushNamed(context, RouteGenerator.addFriendsscreen),
              child: const Text(
                "Add friends",
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
        ),
      ],
    );
  }
}
