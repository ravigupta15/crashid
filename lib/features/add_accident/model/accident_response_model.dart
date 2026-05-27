class AccidentResponseModel {
  bool? success;
  String? message;
  Data? data;

  AccidentResponseModel({this.success, this.message, this.data});

  AccidentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
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

class Data {
  dynamic id;
  dynamic caseNumber;
  dynamic accidentDate;
  dynamic accidentTime;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  dynamic addressDetails;
  dynamic status;
  dynamic paymentStatus;
  dynamic closedAt;
  dynamic createdAt;
  dynamic userAId;
  dynamic userBPlate;
  dynamic userBId;
  dynamic userAPlate;
  dynamic userACarName;
  dynamic userABrand;
  dynamic userAModel;
  dynamic myRole;
  Payment? payment;
  PaymentSummary? paymentSummary;

  Data(
      {this.id,
      this.caseNumber,
      this.accidentDate,
      this.accidentTime,
      this.latitude,
      this.longitude,
      this.address,
      this.addressDetails,
      this.status,
      this.paymentStatus,
      this.closedAt,
      this.createdAt,
      this.userAId,
      this.userBPlate,
      this.userBId,
      this.userAPlate,
      this.userACarName,
      this.userABrand,
      this.userAModel,
      this.myRole,
      this.payment,
      this.paymentSummary});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseNumber = json['case_number'];
    accidentDate = json['accident_date'];
    accidentTime = json['accident_time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    addressDetails = json['address_details'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    closedAt = json['closed_at'];
    createdAt = json['created_at'];
    userAId = json['user_a_id'];
    userBPlate = json['user_b_plate'];
    userBId = json['user_b_id'];
    userAPlate = json['user_a_plate'];
    userACarName = json['user_a_car_name'];
    userABrand = json['user_a_brand'];
    userAModel = json['user_a_model'];
    myRole = json['my_role'];
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    paymentSummary = json['payment_summary'] != null
        ? new PaymentSummary.fromJson(json['payment_summary'])
        : null; }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['case_number'] = caseNumber;
    data['accident_date'] = accidentDate;
    data['accident_time'] = accidentTime;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['address_details'] = addressDetails;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    data['closed_at'] = closedAt;
    data['created_at'] = createdAt;
    data['user_a_id'] = userAId;
    data['user_b_plate'] = userBPlate;
    data['user_b_id'] = userBId;
    data['user_a_plate'] = userAPlate;
    data['user_a_car_name'] = userACarName;
    data['user_a_brand'] = userABrand;
    data['user_a_model'] = userAModel;
    data['my_role'] = myRole;
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (paymentSummary != null) {
      data['payment_summary'] = paymentSummary!.toJson();
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

class PaymentSummary {
  dynamic paymentId;
  dynamic paypalOrderId;
  dynamic approveUrl;
  dynamic serviceCharge;
  dynamic vat;
  dynamic total;
  dynamic currency;
  dynamic paymentMethod;
  dynamic status;
  dynamic note;

  PaymentSummary(
      {this.paymentId,
      this.paypalOrderId,
      this.approveUrl,
      this.serviceCharge,
      this.vat,
      this.total,
      this.currency,
      this.paymentMethod,
      this.status,
      this.note});

  PaymentSummary.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    paypalOrderId = json['paypal_order_id'];
    approveUrl = json['approve_url'];
    serviceCharge = json['service_charge'];
    vat = json['vat'];
    total = json['total'];
    currency = json['currency'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['payment_id'] = paymentId;
    data['paypal_order_id'] = paypalOrderId;
    data['approve_url'] = approveUrl;
    data['service_charge'] = serviceCharge;
    data['vat'] = vat;
    data['total'] = total;
    data['currency'] = currency;
    data['payment_method'] = paymentMethod;
    data['status'] = status;
    data['note'] = note;
    return data;
  }
}