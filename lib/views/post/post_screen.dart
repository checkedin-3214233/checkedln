import 'package:checkedln/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return  PopScope(
      onPopInvoked: (s){
        Get.find<HomeController>().currentBottomIndex.value=0;
        return ;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Post Screen"),automaticallyImplyLeading: false,),
      ),
    );
  }
}
