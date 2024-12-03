import 'package:flutter/material.dart';
import 'package:interactive_comments_section/components/comments/comment/card/footer/reply_button.dart';
import 'package:provider/provider.dart';

import '../../../../models/comment.dart';
import '../../../../provider/comment_provider.dart';
import 'footer/delete_button.dart';
import 'footer/edit_button.dart';
import 'footer/likes.dart';

class CommentCardFooter extends StatelessWidget {
  final int? id;

  const CommentCardFooter({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
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
