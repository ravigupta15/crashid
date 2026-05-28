class CaseDetailsResponseModel {
  bool? success;
  String? message;
  CaseDetails? data;

  CaseDetailsResponseModel({this.success, this.message, this.data});

  CaseDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  CaseDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CaseDetails {
  dynamic id;
  dynamic caseNumber;
  dynamic status;
  dynamic paymentStatus;
  dynamic closedAt;
  dynamic createdAt;
  dynamic requestStatus;
  dynamic myRole;
  CloseStatus? closeStatus;
  Payment? payment;
  List<Participants>? participants;

  CaseDetails(
      {this.id,
      this.caseNumber,
      this.status,
      this.paymentStatus,
      this.closedAt,
      this.createdAt,
      this.requestStatus,
      this.myRole,
      this.closeStatus,
      this.payment,
      this.participants});

  CaseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseNumber = json['case_number'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    closedAt = json['closed_at'];
    createdAt = json['created_at'];
    myRole = json['my_role'];
    requestStatus = json['request_status'];
    payment =
        json['payment'] != null ?  Payment.fromJson(json['payment']) : null;
        closeStatus = json['close_status'] != null
        ?  CloseStatus.fromJson(json['close_status'])
        : null;
    if (json['participants'] != null) {
      participants =  <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['case_number'] = caseNumber;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    data['request_status'] = requestStatus;
    data['closed_at'] = closedAt;
    data['created_at'] = createdAt;
    data['my_role'] = myRole;
    if (closeStatus != null) {
      data['close_status'] = closeStatus!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payment {
  dynamic id;
  dynamic amount;
  dynamic currency;
  dynamic paymentGateway;
  dynamic status;
  dynamic paidAt;

  Payment(
      {this.id,
      this.amount,
      this.currency,
      this.paymentGateway,
      this.status,
      this.paidAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    currency = json['currency'];
    paymentGateway = json['payment_gateway'];
    status = json['status'];
    paidAt = json['paid_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['amount'] = amount;
    data['currency'] = currency;
    data['payment_gateway'] = paymentGateway;
    data['status'] = status;
    data['paid_at'] = paidAt;
    return data;
  }
}

class CloseStatus {
  bool? showCloseButton;
  bool? iHaveRequested;
  bool? userAClosed;
  bool? userBClosed;
  String? message;

  CloseStatus(
      {this.showCloseButton,
      this.iHaveRequested,
      this.userAClosed,
      this.userBClosed,
      this.message});

  CloseStatus.fromJson(Map<String, dynamic> json) {
    showCloseButton = json['show_close_button'];
    iHaveRequested = json['i_have_requested'];
    userAClosed = json['user_a_closed'];
    userBClosed = json['user_b_closed'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['show_close_button'] = showCloseButton;
    data['i_have_requested'] = iHaveRequested;
    data['user_a_closed'] = userAClosed;
    data['user_b_closed'] = userBClosed;
    data['message'] = message;
    return data;
  }
}
class Participants {
  dynamic role;
  dynamic id;
  dynamic username;
  dynamic status;
  dynamic submissionStatus;
  dynamic plate;
  dynamic description;
  dynamic accidentDate;
  dynamic accidentTime;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  dynamic addressDetails;
  List<Images>? images;
  List<Images>? videos;

  Participants(
      {this.role,
      this.id,
      this.username,
      this.status,
      this.submissionStatus,
      this.plate,
      this.description,
      this.accidentDate,
      this.accidentTime,
      this.latitude,
      this.longitude,
      this.address,
      this.addressDetails,
      this.images,
      this.videos});

  Participants.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    id = json['id'];
    username = json['username'];
    status = json['status'];
    submissionStatus = json['submission_status'];
    plate = json['plate'];
    description = json['description'];
    accidentDate = json['accident_date'];
    accidentTime = json['accident_time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    addressDetails = json['address_details'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Images>[];
      json['videos'].forEach((v) {
        videos!.add( Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['role'] = role;
    data['id'] = id;
    data['username'] = username;
    data['status'] = status;
    data['submission_status'] = submissionStatus;
    data['plate'] = plate;
    data['description'] = description;
    data['accident_date'] = accidentDate;
    data['accident_time'] = accidentTime;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['address_details'] = addressDetails;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  dynamic id;
  dynamic fileUrl;
  dynamic createdAt;

  Images({this.id, this.fileUrl, this.createdAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileUrl = json['file_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['file_url'] = fileUrl;
    data['created_at'] = createdAt;
    return data;
  }
}
