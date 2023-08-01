import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propup/bloc/user_data_update.dart';
import 'package:propup/widgets/edit_profile_widgets.dart';

///
///this is for defining the screen for editing the user profile
///
//ignore: camel_case_types
class editProfileScreen extends StatefulWidget {
  const editProfileScreen({super.key});

  @override
  _editProfileScreenState createState() => _editProfileScreenState();
}

class _editProfileScreenState extends State<editProfileScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _locationController;
  late final TextEditingController _descriptionController;
  final  userRf = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid);

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _locationController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 92, 181),
        leading: IconButton(onPressed: ()=> Navigator.pop(context), 
        icon: const Icon(Icons.arrow_back, color: Colors.white,)),
        title: const Text(
          "Account Info",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const profilePicRowWidget(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Full name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                fullNameRowWidget(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "District",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                locationRowWidget(
                  controller: _locationController,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "About you",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                aboutRowWidget(
                  controller: _descriptionController,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          userDataUpdate.editMyAccount(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              location: _locationController.text,
                              description: _descriptionController.text);

                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
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
                      )),
                )
              ],
            )),
      )),
    );
  }
}
