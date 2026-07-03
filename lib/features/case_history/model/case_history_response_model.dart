class CaseHistoryResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  CaseHistoryResponseModel({this.success, this.message, this.data});

  CaseHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic caseNumber;
  dynamic accidentDate;
  dynamic accidentTime;
  dynamic address;
  dynamic status;
  dynamic statusLabel;
  dynamic paymentStatus;
  dynamic userBPlate;
  dynamic closedAt;
  dynamic createdAt;
  dynamic userAPlate;
  dynamic userACarName;
  dynamic myRole;
  List<String>? previewImages;
  dynamic pdfUrl;
  dynamic totalImages;

  Data(
      {this.id,
      this.caseNumber,
      this.accidentDate,
      this.accidentTime,
      this.address,
      this.status,
      this.statusLabel,
      this.paymentStatus,
      this.userBPlate,
      this.closedAt,
      this.createdAt,
      this.userAPlate,
      this.userACarName,
      this.myRole,
      this.previewImages,
      this.pdfUrl,
      this.totalImages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseNumber = json['case_number'];
    accidentDate = json['accident_date'];
    accidentTime = json['accident_time'];
    address = json['address'];
    status = json['status'];
    statusLabel = json['status_label'];
    paymentStatus = json['payment_status'];
    userBPlate = json['user_b_plate'];
    closedAt = json['closed_at'];
    createdAt = json['created_at'];
    userAPlate = json['user_a_plate'];
    userACarName = json['user_a_car_name'];
    myRole = json['my_role'];
    previewImages = json['preview_images'].cast<String>();
    pdfUrl = json['pdf_url'];
    totalImages = json['total_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['case_number'] = caseNumber;
    data['accident_date'] = accidentDate;
    data['accident_time'] = accidentTime;
    data['address'] = address;
    data['status'] = status;
    data['status_label'] = statusLabel;
    data['payment_status'] = paymentStatus;
    data['user_b_plate'] = userBPlate;
    data['closed_at'] = closedAt;
    data['created_at'] = createdAt;
    data['user_a_plate'] = userAPlate;
    data['user_a_car_name'] = userACarName;
    data['my_role'] = myRole;
    data['preview_images'] = previewImages;
    data['pdf_url'] = pdfUrl;
    data['total_images'] = totalImages;
    return data;
  }
}
