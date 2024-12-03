// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      (json['id'] as num?)?.toInt(),
      (json['parentId'] as num?)?.toInt(),
      json['text'] as String,
      (json['likes'] as num?)?.toInt(),
      (json['userAddId'] as num).toInt(),
      (json['userUpdateId'] as num?)?.toInt(),
      DateTime.parse(json['dateAdd'] as String),
      json['dateUpdate'] == null
          ? null
          : DateTime.parse(json['dateUpdate'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'text': instance.text,
      'likes': instance.likes,
      'userAddId': instance.userAddId,
      'userUpdateId': instance.userUpdateId,
      'dateAdd': instance.dateAdd.toIso8601String(),
      'dateUpdate': instance.dateUpdate?.toIso8601String(),
    };
