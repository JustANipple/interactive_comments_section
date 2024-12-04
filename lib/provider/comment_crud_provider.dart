import 'package:flutter/widgets.dart';

class CommentCrudProvider extends ChangeNotifier {
  bool isReplyVisible = false;
  bool isEditVisible = false;

  void onReplyPressed() {
    isReplyVisible = !isReplyVisible;
    notifyListeners();
  }

  void onEditPressed() {
    isEditVisible = !isEditVisible;
    notifyListeners();
  }
}