import 'dart:io';
import 'package:crashid/features/my_cars/model/my_car_response_model.dart';
import 'package:dio/dio.dart';

class AddAccidentSendModel {
  CarData? model;
  List<File>? uploadedPhotos;
  File? uploadedVideo;
  String? des;
  String? caseId;
  String? currentAddress;
  String? witnessAction;

  AddAccidentSendModel({
    this.model,
    this.uploadedPhotos,
    this.uploadedVideo,
    this.des,
    this.caseId,
    this.currentAddress,
    this.witnessAction // accepted/ rejected
  });

  
  Future<FormData> toFormData() async{
    Map <String, dynamic> map = {
      'vehicle_id': model?.id,
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


  
  Future<FormData> userBFormData() async{
    Map <String, dynamic> map = {
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

  
  Future<FormData> userCFormData() async{
    Map <String, dynamic> map = {
      'action': witnessAction,
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