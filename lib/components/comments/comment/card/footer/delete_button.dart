import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../models/comment.dart';
import '../../../../../provider/comment_provider.dart';

class DeleteButton extends StatelessWidget {
  final int? id;

  const DeleteButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        final Comment comment = commentProvider.getCommentById(id!);
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          ),
          onPressed: () {
            commentProvider.deleteCommentById(comment.id!);
          },
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: 20,
                color: Color.fromRGBO(237, 99, 104, 1),
              ),
              SizedBox(width: 5),
              Text(
                "Delete",
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(237, 99, 104, 1),
                  height: 2.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
