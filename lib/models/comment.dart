import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int? id;
  int? parentId;
  String text;
  int? likes;
  int userAddId;
  int? userUpdateId;
  DateTime dateAdd;
  DateTime? dateUpdate;

  Comment(this.id, this.parentId, this.text, this.likes, this.userAddId,
      this.userUpdateId, this.dateAdd, this.dateUpdate);

  Comment.toSend(this.text, this.userAddId, this.dateAdd) {
    likes = 0;
    userUpdateId = userAddId;
    dateUpdate = DateTime.now();
  }

  Comment.toReply(this.text, this.userAddId, this.dateAdd, this.parentId) {
    likes = 0;
    userUpdateId = userAddId;
    dateUpdate = DateTime.now();
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
