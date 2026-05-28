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
      final photos = <MultipartFile>[];
      for (final photo in uploadedPhotos!) {
        photos.add(await MultipartFile.fromFile(photo.path));
      }
      map['images'] = photos;
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
      final photos = <MultipartFile>[];
      for (final photo in uploadedPhotos!) {
        photos.add(await MultipartFile.fromFile(photo.path));
      }
      map['images'] = photos;
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
      final photos = <MultipartFile>[];
      for (final photo in uploadedPhotos!) {
        photos.add(await MultipartFile.fromFile(photo.path));
      }
      map['images'] = photos;
    }

    if (uploadedVideo != null) {
      map['video'] = await MultipartFile.fromFile(uploadedVideo!.path);
    }

    return FormData.fromMap(map);
       
  } 
}