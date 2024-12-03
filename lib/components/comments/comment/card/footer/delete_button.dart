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
            showModal(context, commentProvider, comment.id!);
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

void showModal(BuildContext context, CommentProvider commentProvider, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          'Delete comment',
          style: GoogleFonts.rubik(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(51, 66, 83, 1)),
        ),
        content: Container(
          constraints: BoxConstraints(
            maxWidth: 342,
          ),
          child: Text(
            'Are you sure you want to delete this comment? This will remove the comment and can'
            't be undone.',
            style: GoogleFonts.rubik(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              height: 1.5,
              color: Color.fromRGBO(103, 114, 126, 1),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(103, 114, 126, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  child: Text(
                    "NO, CANCEL",
                    style: GoogleFonts.rubik(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    commentProvider.deleteCommentById(id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(237, 99, 104, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  child: Text(
                    "YES, DELETE",
                    style: GoogleFonts.rubik(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
