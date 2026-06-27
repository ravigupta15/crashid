import 'dart:io';
import 'package:dio/dio.dart';

class AddCarSendModel {
  String? plateNumber;
  String? brand;
  String? model;
  String? carName;
  String? fuelType;
  String? registrationDateFrom;
  String? hpPs;
  String? mileage;
  String? tuevDate;
  String? color;
  String? vinNumber;
  String? insuranceCompany;
  String? insuranceEmail;
  String? insuranceNumber;
  String? insuranceStartDate;
  String? insuranceEndDate;
  List<File> selectedCarImages;
  File? selectedInsurancePdf;
  File? selectedTuevReportPdf;

  AddCarSendModel({
    this.plateNumber,
    this.brand,
    this.model,
    this.carName,
    this.fuelType,
    this.registrationDateFrom,
    this.hpPs,
    this.mileage,
    this.tuevDate,
    this.color,
    this.vinNumber,
    this.insuranceCompany,
    this.insuranceEmail,
    this.insuranceNumber,
    this.insuranceStartDate,
    this.insuranceEndDate,
    this.selectedInsurancePdf,
    this.selectedTuevReportPdf,
    this.selectedCarImages = const [],
  });
  
  Future<FormData> toFormData() async {
    Map<String, dynamic> map = {
       "plate_number": plateNumber,
      "brand_id": brand,
      "model_id": model,
      "car_name": carName,
      "fuel_type": fuelType,
      "registration_date": registrationDateFrom,
      "hp_ps": hpPs,
      "mileage_km": mileage,
      "tuev_date": tuevDate,
      "color_id": color,
      "fin_vin": vinNumber,
      "insurance_company_name": insuranceCompany,
      "insurance_number": insuranceNumber,
      "insurance_email": insuranceEmail,
      "valid_from": insuranceStartDate,
      "valid_until": insuranceEndDate,
    };

    // Handle Files - Only add if they are not null
    if (selectedInsurancePdf != null) {
      map["insurance_image"] = await MultipartFile.fromFile(selectedInsurancePdf!.path);
    }

    if (selectedTuevReportPdf != null) {
      map["tuev_document"] = await MultipartFile.fromFile(selectedTuevReportPdf!.path);
    }
    
    if (selectedCarImages.isNotEmpty) {
      for (int i = 0; i < selectedCarImages.length; i++) {
        map["car_images"] = await MultipartFile.fromFile(selectedCarImages[i].path);
      }
    }

    return FormData.fromMap(map);
  }
}
