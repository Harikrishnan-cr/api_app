class MatchingScheduleJsonModel {
    bool? status;
    ScheduleDatum? data;
    String? message;

    MatchingScheduleJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory MatchingScheduleJsonModel.fromJson(Map<String, dynamic> json) => MatchingScheduleJsonModel(
        status: json["status"],
        data: json["data"] == null ? null : ScheduleDatum.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class ScheduleDatum {
    List<MatchingScheduleModel>? data;
    int? studentId;

    ScheduleDatum({
        this.data,
        this.studentId,
    });

    factory ScheduleDatum.fromJson(Map<String, dynamic> json) => ScheduleDatum(
        data: json["data"] == null ? [] : List<MatchingScheduleModel>.from(json["data"]!.map((x) => MatchingScheduleModel.fromJson(x))),
        studentId: json["studentId"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "studentId": studentId,
    };
}

class MatchingScheduleModel {
    int? id;
    DateTime? date;
    List<AvailableTime>? availableTime;

    MatchingScheduleModel({
        this.id,
        this.date,
        this.availableTime,
    });

    factory MatchingScheduleModel.fromJson(Map<String, dynamic> json) => MatchingScheduleModel(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        availableTime: json["availableTime"] == null ? [] : List<AvailableTime>.from(json["availableTime"]!.map((x) => AvailableTime.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "availableTime": availableTime == null ? [] : List<dynamic>.from(availableTime!.map((x) => x.toJson())),
    };
}

class AvailableTime {
    int? id;
    String? name;

    AvailableTime({
        this.id,
        this.name,
    });

    factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
