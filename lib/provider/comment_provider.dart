import 'package:flutter/material.dart';

import '../database/comment_database.dart';
import '../models/comment.dart';
import '../models/user.dart';

class CommentProvider with ChangeNotifier {
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  final TextEditingController sendTextController = TextEditingController();
  final TextEditingController replyTextController = TextEditingController();
  final TextEditingController editTextController = TextEditingController();
  int userAddId = 1;

  CommentDatabase database = CommentDatabase(); // Use a single instance
  List<Comment> _comments = [];
  List<User> _users = [];

  List<Comment> get comments => _comments;
  List<User> get users => _users;

  CommentProvider() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadComments();
    await loadUsers();
  }

  Future<void> submitComment(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      String text = sendTextController.text.trim();
      final DateTime dateAdd = DateTime.now();
      Comment comment = Comment.toSend(text, userAddId, dateAdd);

      await database.insertComment(comment);
      sendTextController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment added successfully!')),
      );

      await loadComments();
    }
  }

  Future<void> submitReply(BuildContext context, GlobalKey<FormState> formKey,  int? parentId) async {
    if (formKey.currentState?.validate() ?? false) {
      String text = replyTextController.text.trim();
      final DateTime dateAdd = DateTime.now();
      Comment comment = Comment.toReply(text, userAddId, dateAdd, parentId!);

      await database.insertComment(comment);
      replyTextController.clear();

      await loadComments();
    }
  }

  Future<void> submitEdit(BuildContext context, GlobalKey<FormState> formKey, int? id) async {
    if (formKey.currentState?.validate() ?? false) {
      String text = editTextController.text.trim();
      final DateTime dateUpd = DateTime.now();
      Comment comment = comments.where((value) => value.id == id).first;
      comment.text = text;
      comment.dateUpdate = dateUpd;

      await database.updateComment(comment);

      await loadComments();
    }
  }

  Future<void> loadComments() async {
    _comments = await database.readComments();
    notifyListeners();
  }

  Future<void> loadUsers() async {
    _users = await database.readUsers();
    notifyListeners();
  }

  static String calculatePastTime(Comment comment) {
    DateTime currentDateTime = DateTime.now();
    Duration pastTime;
    pastTime = currentDateTime.difference(comment.dateAdd);

    if (pastTime.inSeconds < 60) {
      return "${pastTime.inSeconds} Seconds ago";
    } else if (pastTime.inMinutes < 60) {
      return "${pastTime.inMinutes} Minutes ago";
    } else if (pastTime.inHours < 24) {
      return "${pastTime.inHours} Hours ago";
    } else if (pastTime.inDays < 7) {
      return "${pastTime.inDays} Days ago";
    } else if (pastTime.inDays < 30) {
      return "${(pastTime.inDays / 7).round()} Weeks ago";
    } else {
      return "${(pastTime.inDays / 30).round()} Months ago";
    }
  }

  Future<void> addLike(int? id) async {
    Comment comment = comments.firstWhere((value) => value.id == id);
    if (comment.userUpdateId != userAddId) {
      comment.likes = comment.likes! + 1;
      comment.userUpdateId = userAddId;
      await database.updateComment(comment);
      notifyListeners();
    }
  }

  Future<void> removeLike(int? id) async {
    Comment comment = comments.firstWhere((value) => value.id == id);
    if (comment.likes! > 0 && comment.userUpdateId != userAddId) {
      comment.likes = comment.likes! - 1;
      comment.userUpdateId = userAddId;
      await database.updateComment(comment);
      notifyListeners();
    }
  }

  Comment getCommentById(int id) {
    return comments.firstWhere((value) => value.id == id);
  }

  User getUserById(int id) {
    return users.firstWhere((value) => value.id == id);
  }

  void deleteCommentById(int id) {
    database.deleteComment(comments.firstWhere((value) => value.id == id));
    loadComments();
  }

  List<Comment> getCommentsWithoutReplies() {
    return comments.where((comment) => comment.parentId == null).toList();
  }

  void setUser(int id) {
    userAddId = id;
    notifyListeners();
  }
}
