class NotificationResponseModel {
  bool? success;
  String? message;
  Data? data;

  NotificationResponseModel({this.success, this.message, this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? unreadCount;
  List<Notifications>? notifications;

  Data({this.unreadCount, this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unread_count'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add( Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['unread_count'] = unreadCount;
    if (this.notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  dynamic id;
  dynamic type;
  dynamic caseId;
  dynamic sosId;
  dynamic title;
  dynamic body;
  dynamic isRead;
  dynamic readAt;
  dynamic createdAt;
  dynamic caseNumber;
  dynamic caseStatus;
  dynamic accidentDate;
  dynamic accidentTime;
  dynamic location;
  dynamic requestStatus;
  Sos? sos;

  Notifications(
      {this.id,
      this.type,
      this.caseId,
      this.sosId,
      this.title,
      this.body,
      this.isRead,
      this.readAt,
      this.createdAt,
      this.caseNumber,
      this.caseStatus,
      this.accidentDate,
      this.accidentTime,
      this.location,
      this.requestStatus,
      this.sos});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    caseId = json['case_id'];
    sosId = json['sos_id'];
    title = json['title'];
    body = json['body'];
    isRead = json['is_read'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    caseNumber = json['case_number'];
    caseStatus = json['case_status'];
    accidentDate = json['accident_date'];
    accidentTime = json['accident_time'];
    location = json['location'];
    requestStatus = json['request_status'];
    sos = json['sos'] != null ? Sos.fromJson(json['sos']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['case_id'] = caseId;
    data['sos_id'] = sosId;
    data['title'] = title;
    data['body'] = body;
    data['is_read'] = isRead;
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['case_number'] = caseNumber;
    data['case_status'] = caseStatus;
    data['accident_date'] = accidentDate;
    data['accident_time'] = accidentTime;
    data['location'] = location;
    data['request_status'] = requestStatus;
    if (sos != null) {
      data['sos'] = sos!.toJson();
    }
    return data;
  }
}
class Sos {
  String? senderName;
  String? latitude;
  String? longitude;
  String? location;
  String? myAction;

  Sos({this.senderName, this.latitude, this.longitude, this.location, this.myAction});

  Sos.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    myAction = json['my_action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['sender_name'] = senderName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['my_action'] = myAction;
    return data;
  }
}