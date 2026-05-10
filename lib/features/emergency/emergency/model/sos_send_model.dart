class SosSendModel {
  String? lat;
  String? lng;
  String? address;
  String? msg;

  SosSendModel({
    this.lat,
    this.lng,
    this.address,
    this.msg
  });

  Map<String, dynamic> toMap() {
    return {
  "latitude": lat,
  "longitude": lng,
  "address": address,
  "msg": msg
    };
  }
}