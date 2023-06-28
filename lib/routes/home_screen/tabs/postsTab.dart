
import 'package:flutter/material.dart';
import 'package:propup/widgets/home_screen_widgets.dart';

///
///this is where the post tabs shall be created from
///
//ignore:camel_case_types
class postsTab extends StatelessWidget{
  const postsTab({super.key});

  @override
  Widget build(BuildContext context){
    return  SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            const postsTopWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (contxt, index){
                  return const Padding(padding: EdgeInsets.all(10),child:postsTabPostWidget(image: "assets/images/profile.jpg"));}))
        ],
      ));
  }
}