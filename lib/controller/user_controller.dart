import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:checkedln/models/user/userModel.dart';
import 'package:checkedln/services/user/userServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/upload_image.dart';

class UserController extends GetxController{
    UserServices _userServices = UserServices();
    UploadImage _uploadImage = UploadImage();
    var isImageUploading = false.obs;

    TextEditingController firstName = TextEditingController();
    TextEditingController lastName = TextEditingController();
    TextEditingController userName = TextEditingController();
    TextEditingController dateOfBirth = TextEditingController();
    TextEditingController gender = TextEditingController(text: "Your Gender");
    TextEditingController bio = TextEditingController();
    var profileUrl="".obs;
    var isLoading = false.obs;
     var userModel = Rxn<UserModel>();
     var currentImageCount = 0.obs;
    Timer? _timer;
    startTimer(){
        _timer = Timer.periodic(Duration(seconds: 3), (timer) {
            if(currentImageCount.value==userModel.value!.userImages!.length-1){
                currentImageCount.value=0;
            }else{
                currentImageCount.value++;
            }
        });
    }
    Future<String> uploadImage(File file)async{
        isImageUploading.value = true;
        try{
            String path  =await _uploadImage.uploadImage(file);
            isImageUploading.value = false;
            return path ;
        }catch (e){
            isImageUploading.value = false;

            return "";
        }


    }

    getUser()async{
        isLoading.value = true;
        try{
            dio.Response response =await _userServices.getUser();
            if (response.statusCode == 200 || response.statusCode == 201) {
                userModel.value = UserModel.fromJson(response.data["user"]);
                List<String> splitName = userModel.value!.name!.split(" ");
                firstName.text= splitName[0];
                lastName.text = splitName.last;
                userName.text = userModel.value!.userName!;
                dateOfBirth.text = userModel.value!.dateOfBirth!.toString();
                gender.text = userModel.value!.gender!;
                bio.text = userModel.value!.bio!;
                profileUrl.value = userModel.value!.profileImageUrl!;
                startTimer();
            }else{

            }
        }catch(e){
            Get.rawSnackbar(message: "Some error occurred at our end $e");

        }
        isLoading.value = false;
    }
    updateUser()async{
        isLoading.value = true;
        try{
            dio.Response response = await _userServices.updateUser(userName.text, firstName.text +" "+ lastName.text, profileUrl.value, DateTime.parse(dateOfBirth.text), gender.text, bio.text);
            if (response.statusCode == 200 || response.statusCode == 201) {
                userModel.value = UserModel.fromJson(response.data["user"]);
                List<String> splitName = userModel.value!.name!.split(" ");
                firstName.text= splitName[0];
                lastName.text = splitName.last;
                userName.text = userModel.value!.userName!;
                dateOfBirth.text = userModel.value!.dateOfBirth!.toString();
                gender.text = userModel.value!.gender!;
                bio.text = userModel.value!.bio!;
                profileUrl.value = userModel.value!.profileImageUrl!;
                isLoading.value = false;
                Get.back();
            }else{

            }
        }catch(e){
            Get.rawSnackbar(message: "Some error occurred at our end $e");

        }
        isLoading.value = false;
    }
}