class QuizzInstructionsJsonModel {
    bool? status;
    List<QuizzInstructionsModel>? data;
    String? message;

    QuizzInstructionsJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory QuizzInstructionsJsonModel.fromJson(Map<String, dynamic> json) => QuizzInstructionsJsonModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<QuizzInstructionsModel>.from(json["data"]!.map((x) => QuizzInstructionsModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class QuizzInstructionsModel {
    int? id;
    String? examDisplayId;
    List<String>? instructions;
    String? image;
    String? encodedId;
    List<Media>? media;

    QuizzInstructionsModel({
        this.id,
        this.examDisplayId,
        this.instructions,
        this.image,
        this.encodedId,
        this.media,
    });

    factory QuizzInstructionsModel.fromJson(Map<String, dynamic> json) => QuizzInstructionsModel(
        id: json["id"],
        examDisplayId: json["examDisplayId"],
        instructions: json["instructions"] == null ? [] : List<String>.from(json["instructions"]!.map((x) => x)),
        image: json["image"],
        encodedId: json["encodedId"],
        media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "examDisplayId": examDisplayId,
        "instructions": instructions,
        "image": image,
        "encodedId": encodedId,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
    };
}

class Media {
    int? id;
    String? modelType;
    int? modelId;
    String? uuid;
    String? collectionName;
    String? name;
    String? fileName;
    String? mimeType;
    String? disk;
    String? conversionsDisk;
    int? size;
    List<dynamic>? manipulations;
    List<dynamic>? customProperties;
    List<dynamic>? generatedConversions;
    List<dynamic>? responsiveImages;
    int? orderColumn;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? originalUrl;
    String? previewUrl;

    Media({
        this.id,
        this.modelType,
        this.modelId,
        this.uuid,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.conversionsDisk,
        this.size,
        this.manipulations,
        this.customProperties,
        this.generatedConversions,
        this.responsiveImages,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.originalUrl,
        this.previewUrl,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: json["modelType"],
        modelId: json["modelId"],
        uuid: json["uuid"],
        collectionName: json["collectionName"],
        name: json["name"],
        fileName: json["fileName"],
        mimeType: json["mimeType"],
        disk: json["disk"],
        conversionsDisk: json["conversionsDisk"],
        size: json["size"],
        manipulations: json["manipulations"] == null ? [] : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
        customProperties: json["customProperties"] == null ? [] : List<dynamic>.from(json["customProperties"]!.map((x) => x)),
        generatedConversions: json["generatedConversions"] == null ? [] : List<dynamic>.from(json["generatedConversions"]!.map((x) => x)),
        responsiveImages: json["responsiveImages"] == null ? [] : List<dynamic>.from(json["responsiveImages"]!.map((x) => x)),
        orderColumn: json["orderColumn"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        originalUrl: json["originalUrl"],
        previewUrl: json["previewUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "modelType": modelType,
        "modelId": modelId,
        "uuid": uuid,
        "collectionName": collectionName,
        "name": name,
        "fileName": fileName,
        "mimeType": mimeType,
        "disk": disk,
        "conversionsDisk": conversionsDisk,
        "size": size,
        "manipulations": manipulations == null ? [] : List<dynamic>.from(manipulations!.map((x) => x)),
        "customProperties": customProperties == null ? [] : List<dynamic>.from(customProperties!.map((x) => x)),
        "generatedConversions": generatedConversions == null ? [] : List<dynamic>.from(generatedConversions!.map((x) => x)),
        "responsiveImages": responsiveImages == null ? [] : List<dynamic>.from(responsiveImages!.map((x) => x)),
        "orderColumn": orderColumn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "originalUrl": originalUrl,
        "previewUrl": previewUrl,
    };
}
