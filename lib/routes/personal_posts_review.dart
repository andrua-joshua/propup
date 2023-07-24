import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class personalPostsReview extends StatelessWidget {
  final String src;
  const personalPostsReview({required this.src, super.key});

  @override
  Widget build(BuildContext context) {
    final postsStore = FirebaseFirestore.instance.collection("posts");
    final storageRf = FirebaseStorage.instance.ref();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder<String>(
            future: storageRf.child("posts/" + src).getDownloadURL(),
            builder: (context, snap) {
              if (snap.hasData) {
                return Image.network(snap.data ?? "");
              }
              if (snap.hasError) {
                return const Center(
                    child: Text(
                  "(*_*)",
                  style: TextStyle(color: Colors.redAccent),
                ));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: StreamBuilder(
            stream: postsStore.doc(src).snapshots(),
            builder: (context, snap) {
              if (snap.hasData) {
                return Text(
                  (snap.data?.get("likes").toString() ?? "00") + " likes",
                  style: const TextStyle(color: Colors.black),
                );
              }
              if (snap.hasError) {
                return const Text(
                  "(*_*)",
                  style: TextStyle(color: Colors.redAccent),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
