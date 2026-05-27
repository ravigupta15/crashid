import 'package:crashid/utils/date_format/app_date_format.dart';

class OtherAccidentSendModel {
  String? otherDriver;
  String? witness;
  String? date;
  String? time;
  String? currentAddress;
  String? lat;
  String? lng;
  String? caseId;

  OtherAccidentSendModel({
    this.otherDriver,
    this.witness,
    this.date,
    this.time,
    this.currentAddress,
    this.lat,
    this.lng,
    this.caseId
  });

  Map<String, dynamic> toMap() {
    return {
  "user_b_plate": otherDriver,
  "witness_plate": witness,
  "accident_date": AppDateFormat.convertToIsoFormat(date ?? ''),
  "accident_time": AppDateFormat.convertTo24Hour(time ?? ''),
  "latitude": lat,
  "longitude": lng,
  "address": currentAddress,
  "payment_method": "paypal"
};
  }
}