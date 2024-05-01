class NotificationsJsonModel {
  bool? status;
  List<NotificationModel>? data;
  String? message;

  NotificationsJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory NotificationsJsonModel.fromJson(Map<String, dynamic> json) =>
      NotificationsJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<NotificationModel>.from(
                json["data"]!.map((x) => NotificationModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class NotificationModel {
  int? id;
  String? title;
  String? description;
  String? status;
  String? scheduledDate;
  String? scheduledTime;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.scheduledDate,
    this.scheduledTime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        scheduledDate: json["scheduledDate"],
        scheduledTime: json["scheduledTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "scheduledDate": scheduledDate,
        "scheduledTime": scheduledTime,
      };
}
