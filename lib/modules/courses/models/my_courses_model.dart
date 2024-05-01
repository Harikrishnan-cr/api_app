class MyCoursesJsonModel {
  bool? status;
  MyCoursesDataModel? data;
  String? message;

  MyCoursesJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory MyCoursesJsonModel.fromJson(Map<String, dynamic> json) =>
      MyCoursesJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : MyCoursesDataModel.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class MyCoursesDataModel {
  List<MyCourse>? courses;

  MyCoursesDataModel({
    this.courses,
  });

  factory MyCoursesDataModel.fromJson(Map<String, dynamic> json) =>
      MyCoursesDataModel(
        courses: json["courses"] == null
            ? []
            : List<MyCourse>.from(
                json["courses"]!.map((x) => MyCourse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "courses": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
      };
}

class MyCourse {
  int? id;
  String? title;
  String? courseDisplayId;
  String? description;
  int? price;
  String? courseDuration;
  int? isPopular;
  String? photoUrl;
  String? image;
  String? paidStatus;
  double? viewed;
  String? encodedId;
  String? signedPhotoUrl;

  MyCourse({
    this.id,
    this.title,
    this.courseDisplayId,
    this.description,
    this.price,
    this.courseDuration,
    this.isPopular,
    this.photoUrl,
    this.image,
    this.paidStatus,
    this.viewed,
    this.encodedId,
    this.signedPhotoUrl,
  });

  factory MyCourse.fromJson(Map<String, dynamic> json) => MyCourse(
        id: json["id"],
        title: json["title"],
        courseDisplayId: json["courseDisplayId"],
        description: json["description"],
        price: json["price"],
        courseDuration: json["courseDuration"],
        isPopular: json["isPopular"],
        photoUrl: json["photoUrl"],
        image: json["image"],
        paidStatus: json["paidStatus"],
        viewed: double.parse(json["viewed"].toString()),
        encodedId: json["encodedId"],
        signedPhotoUrl: json["signedPhotoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "courseDisplayId": courseDisplayId,
        "description": description,
        "price": price,
        "courseDuration": courseDuration,
        "isPopular": isPopular,
        "photoUrl": photoUrl,
        "image": image,
        "paidStatus": paidStatus,
        "viewed": viewed,
        "encodedId": encodedId,
        "signedPhotoUrl": signedPhotoUrl,
      };
}
