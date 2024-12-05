import 'package:flutter/material.dart';
import 'package:interactive_comments_section/components/comments/comment/card/footer/reply_button.dart';
import 'package:interactive_comments_section/provider/comment_crud_provider.dart';
import 'package:provider/provider.dart';

import '../../../../models/comment.dart';
import '../../../../provider/comment_provider.dart';
import 'footer/delete_button.dart';
import 'footer/edit_button.dart';
import 'footer/likes.dart';
import 'footer/update_button.dart';

class CommentCardFooter extends StatelessWidget {
  final int? id;

  const CommentCardFooter({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommentProvider, CommentCrudProvider>(
      builder: (context, commentProvider, commentCrudProvider, child) {
        final Comment comment = commentProvider.getCommentById(id!);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Likes(id: comment.id),
            commentProvider.userAddId == comment.userAddId
                ? Row(
                  children: [
                    Row(
                      children: [
                        if (commentCrudProvider.isEditVisible)
                          UpdateButton(
                              formKey: commentProvider.editFormKey,
                              id: comment.id)
                        else
                          DeleteButton(id: comment.id),
                        EditButton(),
                      ],
                    ),
                  ],
                )
                : ReplyButton(),
          ],
        );
      },
    );
  }
}
