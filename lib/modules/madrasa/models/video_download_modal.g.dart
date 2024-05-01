// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_download_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoDownlaodModelClassAdapter
    extends TypeAdapter<VideoDownlaodModelClass> {
  @override
  final int typeId = 1;

  @override
  VideoDownlaodModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoDownlaodModelClass(
      discription: fields[3] as String,
      thumbImgMemory: fields[8] as Uint8List?,
      dowlaodPath: fields[0] as String,
      materilaID: fields[9] as int,
      deviceID: fields[6] as String,
      videoDuration: fields[4] as String,
      thumbanailUrl: fields[1] as String,
      userId: fields[5] as int,
      title: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoDownlaodModelClass obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.dowlaodPath)
      ..writeByte(1)
      ..write(obj.thumbanailUrl)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.discription)
      ..writeByte(4)
      ..write(obj.videoDuration)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.deviceID)
      ..writeByte(8)
      ..write(obj.thumbImgMemory)
      ..writeByte(9)
      ..write(obj.materilaID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoDownlaodModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
