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

  Notifications(
      {this.id,
      this.type,
      this.caseId,
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
      this.requestStatus});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    caseId = json['case_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['case_id'] = caseId;
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
    return data;
  }
}
