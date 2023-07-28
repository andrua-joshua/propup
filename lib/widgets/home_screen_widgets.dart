import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/src/cache_manager.dart';
import 'package:flutter_cache_manager/src/config/config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:propup/routes.dart';
import 'package:http/http.dart' as http;

///
///this is where all the custome widgets of the home screen are to be created from
///

///
///this will be used for showing the salutation widget on the home screen
///
//ignore: camel_case_types
class helloTitleWidget extends StatelessWidget {
  const helloTitleWidget({super.key});

  @override
  Widget build(BuildContext) {
    final user = FirebaseAuth.instance.currentUser;
    final usersStore =
        FirebaseFirestore.instance.collection("users").doc(user?.uid);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: usersStore.snapshots(),
              builder: (context, snap) {
                if (snap.hasError) {
                  return const Text("Error retriving the info",
                      style: TextStyle(color: Colors.red));
                }

                if (snap.hasData) {
                  if (snap.data != null) {
                    return GestureDetector(
                      onTap: ()=>Navigator.pushNamed(context,RouteGenerator.myProfilescreen),
                      child:Text(
                      snap.data?.get("username"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ));
                  }
                }

                return const Center(child: CircularProgressIndicator());
              }),
          const Text(
            "Good morning",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          )
        ],
      ),
    );
  }
}

///
///this is for showing the current account size
///
//ignore: camel_case_types
class accountBalanceWidget extends StatelessWidget {
  const accountBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snap) {
        if (snap.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "UGX ${snap.data?.get("account_balance")}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat("MM-dd-yyyy").format(DateTime.now()),
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          );
        }

        if (snap.hasError) {
          return const Center(
              child: Text(
            "(*_*)",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ));
        }

        return Center(
            child: Container(
                width: 130,
                height: 50,
                color: const Color.fromARGB(155, 179, 177, 177)));
      },
    );
  }
}

///
///This is responsible for the grid of the navigations
///
//ignore:camel_case_types
class gridDataWidget extends StatelessWidget {
  const gridDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          mainAxisExtent: 150),
      children: [
        gridData(
            title: "Friends",
            callBack: () =>
                Navigator.pushNamed(context, RouteGenerator.friendscreen)),
        gridData(
            title: "Fund Raise",
            callBack: () =>
                Navigator.pushNamed(context, RouteGenerator.fundRaisescreen)),
        gridData(
            title: "Transactions",
            callBack: () => Navigator.pushNamed(
                context, RouteGenerator.transactionsscreen)),
        gridData(
            title: "Loan",
            callBack: () =>
                Navigator.pushNamed(context, RouteGenerator.loanscreen)),
        gridData(
            title: "LeaderBoard",
            callBack: () {},),
            // => Navigator.pushNamed(
            //     context, RouteGenerator.leadersboardscreenportal)),
        gridData(title: "Overview Compaigns", callBack: () => Navigator.pushNamed(
            context, RouteGenerator.overviewscreen)
            ),
      ],
    );
  }
}

///for just the grid data
//ignore: camel_case_types
class gridData extends StatelessWidget {
  final String title;
  void Function() callBack;
  gridData({required this.title, required this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: GestureDetector(
          onTap: callBack,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(255, 88, 94, 98),),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }
}

////
///this is where all the postsTab widgets are

///
///posts top row widget here
///
//ignore:camel_case_types
class postsTopWidget extends StatelessWidget {
  const postsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 156, 236, 247),
                    Color.fromARGB(255, 182, 236, 243),
                    Color.fromARGB(255, 253, 216, 247),
                    Color.fromARGB(255, 245, 177, 241),
                  ])),
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.all(4),
                        child: CircleAvatar(
                          backgroundColor: Colors.cyanAccent,
                          radius: 25,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 22,
                            backgroundImage:
                                AssetImage("assets/images/profile.jpg"),
                          ),
                        ))))
          ],
        ));
  }
}

///
///post widget where the exact post shall be placed
///
//ignore:camel_case_types
class postsTabPostWidget extends StatelessWidget {
  final String image;
  const postsTabPostWidget({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    final postsStore = FirebaseFirestore.instance.collection("posts");
    final usersStore = FirebaseFirestore.instance.collection("users");
    final storageRf = FirebaseStorage.instance.ref();

    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return FutureBuilder<String>(
          future: storageRf.child("posts/" + image).getDownloadURL(),
          builder: (context, snap) {
            if (snap.hasError) {
              return const Center(
                child: Text("(*_*)",
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold)),
              );
            }
            if (snap.hasData) {
              return FutureBuilder<ImageDescriptor>(
                  future: http
                      .get(Uri.parse(snap.data ?? ""))
                      .then((value) => value.bodyBytes)
                      .then((value) => ImmutableBuffer.fromUint8List(value))
                      .then((value) => ImageDescriptor.encoded(value)),
                  builder: (context, value) {
                    if (value.hasError) {
                      return const Center(
                        child: Text(
                          "there occurred some error",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      );
                    }
                    if (value.hasData == false) {
                      return const Center(
                          //child: CircularProgressIndicator(),
                          );
                    }
                    int h = 0;
                    int w = 0;

                    if (value.hasData) {
                      h = value.data?.height ?? 1;
                      w = value.data?.width ?? 1;
                    }
                    return Container(
                      constraints:
                          BoxConstraints.expand(height: width / (w / h)),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(snap.data ?? "",
                                  cacheKey: "customcache",
                                  cacheManager: CacheManager(Config(
                                      "customcache",
                                      stalePeriod: const Duration(days: 7),
                                      maxNrOfCacheObjects: 200))),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 224, 221, 221)),
                      padding: const EdgeInsets.fromLTRB(3, 6, 3, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          postOwnerWidget(
                            postId: image,
                          ),
                          const Expanded(child: SizedBox()),
                          reactionOptionsWidget(
                            postId: image,
                          )
                        ],
                      ),
                    );
                  });
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    });
  }
}

/**
 * Container(
                      constraints:
                          BoxConstraints.expand(height: width / (w / h)),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(snap.data ?? ""),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 224, 221, 221)),
                      padding: const EdgeInsets.fromLTRB(3, 6, 3, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          postOwnerWidget(
                            postId: image,
                          ),
                          const Expanded(child: SizedBox()),
                          reactionOptionsWidget(
                            postId: image,
                          )
                        ],
                      ),
                    )
 */

///this is for showing the user who had posted the image
//ignore:camel_case_types
class postOwnerWidget extends StatelessWidget {
  final String postId;
  const postOwnerWidget({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    final postsStore = FirebaseFirestore.instance.collection("posts");
    final usersStore = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
        future: postsStore.doc(postId).get(),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListTile(
              onTap: () => Navigator.pushNamed(
                  context, RouteGenerator.friendprofilescreen),
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                    "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg"),
              ),
              title: FutureBuilder<DocumentSnapshot>(
                future: usersStore.doc(snap.data?.get("owner")).get(),
                builder: (context, value) {
                  if (value.hasData) {
                    return Text(
                      value.data?.get("username"),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    );
                  }

                  if (value.hasError) {
                    return const Center(
                      child: Text(
                        "(*_*)",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  return const Center(
                      //child: CircularProgressIndicator(),
                      );
                },
              ),
              subtitle: const Text(
                "2 hrs ago",
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            );
          }

          if (snap.hasError) {
            return const Center(
                child: Text(
              "(*_*)",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ));
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

///
///this is for showing reaction options about the post
///
//ignore:camel_case_types
class reactionOptionsWidget extends StatelessWidget {
  final String postId;

  const reactionOptionsWidget({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    final postsStore = FirebaseFirestore.instance.collection("posts");

    return LayoutBuilder(builder: (context, dimensions) {
      double width = dimensions.maxWidth;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {},
              child: Container(
                width: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(180, 240, 239, 239)),
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.heart_broken_outlined,
                      color: Colors.white,
                    ),
                    StreamBuilder(
                        stream: postsStore.doc(postId).snapshots(),
                        builder: (context, snap) {
                          if (snap.hasData) {
                            return Text(
                              snap.data?.get("likes"),
                              style: const TextStyle(color: Colors.white),
                            );
                          }

                          if (snap.hasError) {
                            return const Center(
                              child: Text(
                                "(*_*)",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }

                          return const Center(
                              //child: CircularProgressIndicator(),
                              );
                        })
                  ],
                ),
              )),
          TextButton(
              onPressed: () => Navigator.pushNamed(
                  context, RouteGenerator.postsCommentscreen),
              child: Container(
                width: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(180, 240, 239, 239)),
                padding: const EdgeInsets.all(2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    Text(
                      "1.2k",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Container(
                width: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(180, 240, 239, 239)),
                padding: const EdgeInsets.all(2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    Text(
                      "365",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ))
        ],
      );
    });
  }
}

////
///this is where the chat tab widgets are created from
///
class chatSearchWidget extends StatefulWidget {
  const chatSearchWidget({super.key});

  @override
  _chatSearchWidgetState createState() => _chatSearchWidgetState();
}

//ignore:camel_case_types
class _chatSearchWidgetState extends State<chatSearchWidget> {
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
    return Row(children: [
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 241, 241, 241)),
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
              ))),
      TextButton(
          onPressed: () {
            
            showBottomSheet(
                elevation: 10,
                context: context,
                builder: (context) {
                  return const allFriendsListWidget();
                });
          },
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(6),
            child: const Icon(Icons.mark_unread_chat_alt_rounded),
          ))
    ]);
  }
}

//ignore:camel_case_types
class allFriendsListWidget extends StatelessWidget {
  const allFriendsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    return Column(children: [
      // SizedBox(
      //   height: 50,
      //   child: Container(),

      // ),
      Container(
        constraints: const BoxConstraints.expand(height: 65),
        child: const Column(
          children: [
            SizedBox(height: 30,),
            Divider(thickness: 2, color: Colors.white,),
            Divider(thickness: 2, color: Colors.white,)
          ],
        ),
      ),
      const Text(
        "All friends",
        style: TextStyle(color: Colors.black),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: currentUser.snapshots(),
            builder: (conext, snap) {
              if (snap.hasData) {
                return Column(
                    children: List.generate(
                        (snap.data?.get("friendsList") as List).length,
                        (index) => FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("users")
                                .doc((snap.data?.get("friendsList") as List)[index])
                                .get(),
                            builder: (context, value) {
                              if (value.hasData) {
                                return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: ListTile(
                                      onTap: () {
                                        //sending it to the messaging screen
                                        Navigator.pushNamed(context,
                                            RouteGenerator.messagingscreen,
                                            arguments: value.data?.id);
                                      },
                                      leading: const CircleAvatar(
                                        radius: 33,
                                        backgroundImage: NetworkImage(
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf5M2j5aP_QleSz2Sb2Qgf-J5UgjP3po54hg&usqp=CAU"),
                                      ),
                                      title: Text(value.data?.get("username")),
                                      subtitle: Text(
                                        value.data?.get("description"),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ));
                              }

                              if (value.hasError) {
                                return const Text(
                                  "(*_*)",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                );
                              }

                              return Container(
                                constraints:
                                    const BoxConstraints.expand(height: 50),
                               
                                decoration: BoxDecoration(
                                   color: const Color.fromARGB(255, 241, 241, 241),
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                              );
                            })));
              }

              if (snap.hasError) {
                return const Center(
                  child: Text(
                    "(*_*)\n check your internet connection and try again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                );
              }

              return Container(
                constraints: const BoxConstraints.expand(height: 400),
                color: const Color.fromARGB(255, 241, 241, 241),
                margin: const EdgeInsets.all(10),
              );
            },
          ),
        ),
      )
    ]);
  }
}

///
///this is for the user view
///
//ignore:camel_case_types
class chatUserWidget extends StatelessWidget {
  final String userId;
  final String image;
  final String name;
  final String message;
  const chatUserWidget(
      {required this.message,
      required this.userId,
      required this.name,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        //sending it to the messaging screen
        Navigator.pushNamed(
          context, 
          RouteGenerator.messagingscreen,
          arguments: userId);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 24,
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(image),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

//ignore:camel_case_types
class postsCommentWidget extends StatelessWidget {
  final String image;
  final String name;
  final String comment;
  const postsCommentWidget(
      {required this.image,
      required this.comment,
      required this.name,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(image),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                "1 month ago",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        Text(comment),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.heart_broken_outlined)),
              // const SizedBox(
              //   width: 4,
              // ),
              const Text(
                "23",
                style: TextStyle(color: Colors.blueGrey),
              )
            ],
          ),
        )
      ],
    );
  }
}

//ignore:camel_case_types
class commentingAreaWidget extends StatefulWidget {
  const commentingAreaWidget({super.key});

  @override
  _commentingAreaWidgetState createState() => _commentingAreaWidgetState();
}

//ignore:camel_case_types
class _commentingAreaWidgetState extends State<commentingAreaWidget> {
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1)),
          padding: const EdgeInsets.all(3),
          child: TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Add a comment...."),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              GestureDetector(
                child: Container(
                  ///width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 11, 70, 119)),
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    "SEND",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
