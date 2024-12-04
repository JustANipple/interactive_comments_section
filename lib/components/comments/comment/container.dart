import 'package:flutter/material.dart';
import 'package:interactive_comments_section/provider/comment_crud_provider.dart';
import 'package:interactive_comments_section/provider/comment_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/comment.dart';
import '../../../models/user.dart';
import 'card/body.dart';
import 'card/body_edit.dart';
import 'card/footer.dart';
import 'card/header.dart';
import 'reply_form.dart';

class CommentContainer extends StatelessWidget {
  final User user;
  final Comment comment;

  const CommentContainer({
    super.key,
    required this.user,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommentProvider, CommentCrudProvider>(
      builder: (context, commentProvider, commentCrudProvider, child) {
        final List<Comment> replies = commentProvider.comments
            .where((value) => value.parentId == comment.id)
            .toList();
        final List<User> users = commentProvider.users;

        return Column(
          children: [
            CommentCard(user: user, comment: comment),
            if (commentCrudProvider.isReplyVisible)
              ReplyForm(parentId: comment.id),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: replies.length,
              itemBuilder: (context, index) {
                final Comment replyComment = replies[index];
                final User replyUser = users
                    .firstWhere((value) => value.id == replyComment.userAddId);

                return Container(
                  margin: EdgeInsets.only(top: index == 0 ? 16 : 0),
                  padding: EdgeInsets.only(
                    left: 16,
                    top: index == 0 ? 0 : 8,
                    bottom: index == replies.length - 1 ? 0 : 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color.fromRGBO(233, 235, 240, 1),
                        width: 2,
                      ),
                    ),
                  ),
                  child: ChangeNotifierProvider(
                    create: (_) => CommentCrudProvider(),
                    child: CommentContainer(
                      user: replyUser,
                      comment: replyComment,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  final User user;

  const CommentCard({super.key, required this.comment, required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentCrudProvider>(
        builder: (context, commentCrudProvider, child) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommentCardHeader(comment: comment, user: user),
            SizedBox(height: 16),
            if (commentCrudProvider.isEditVisible)
              CommentCardBodyEdit(id: comment.id!)
            else
              CommentCardBody(id: comment.id),
            SizedBox(height: 16),
            CommentCardFooter(id: comment.id),
          ],
        ),
      );
    });
  }
}
