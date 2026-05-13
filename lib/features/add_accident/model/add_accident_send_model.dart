import 'dart:io';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';
import 'package:dio/dio.dart';

class AddAccidentSendModel {
  UserModel? model;
  List<File>? uploadedPhotos;
  File? uploadedVideo;
  String? des;

  AddAccidentSendModel({
    this.model,
    this.uploadedPhotos,
    this.uploadedVideo,
    this.des
  });

  
  Future<FormData> toFormData() async{
    Map <String, dynamic> map = {
      'vehicle_id': model?.vehicleId,
      'description': des
    
    };
    
    if ((uploadedPhotos ?? []).isNotEmpty) {
      for (int i = 0; i < uploadedPhotos!.length; i++) {
        map["images"] = await MultipartFile.fromFile(uploadedPhotos![i].path);
      }
    }

    if (uploadedVideo != null) {
      map['video'] = await MultipartFile.fromFile(uploadedVideo!.path);
    }

    return FormData.fromMap(map);
       
  }

 
}