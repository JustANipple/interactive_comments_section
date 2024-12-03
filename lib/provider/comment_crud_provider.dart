import 'package:flutter/widgets.dart';

class CommentCrudProvider extends ChangeNotifier {
  bool isReplyVisible = false;

  void onReplyPressed() {
    isReplyVisible = !isReplyVisible;
    notifyListeners();
  }
}