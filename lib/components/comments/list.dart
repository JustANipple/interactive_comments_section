import 'package:flutter/material.dart';
import 'package:interactive_comments_section/provider/comment_crud_provider.dart';
import 'package:provider/provider.dart';

import '../../models/comment.dart';
import '../../models/user.dart';
import '../../provider/comment_provider.dart';
import 'comment/container.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentCrudProvider(),
      child: Consumer2<CommentProvider, CommentCrudProvider>(
        builder: (context, commentProvider, commentCrudProvider, child) {
          final List<Comment> comments = commentProvider.getCommentsWithoutReplies();
          final List<User> users = commentProvider.users;
          return Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final Comment comment = comments[index];
                final User user = users.firstWhere(
                    (value) => value.id == comments[index].userAddId);
                  return Column(
                    children: [
                      CommentContainer(
                          user: user,
                          comment: comment),
                      SizedBox(height: 16)
                    ],
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
