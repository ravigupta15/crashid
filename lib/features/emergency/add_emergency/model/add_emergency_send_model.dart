class AddEmergencySendModel {
  String? userId;
  String? plateNumber;

  AddEmergencySendModel({
    this.userId,
    this.plateNumber,
  });

  Map<String, dynamic> toMap() {
    return {
  "friend_user_id": userId,
  "plate_number": plateNumber,
  "category": "friend"
};
  }
}