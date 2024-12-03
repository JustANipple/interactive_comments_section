import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interactive_comments_section/provider/comment_crud_provider.dart';
import 'package:provider/provider.dart';

class ReplyButton extends StatefulWidget {
  const ReplyButton({super.key});

  @override
  State<ReplyButton> createState() => _ReplyButtonState();
}

class _ReplyButtonState extends State<ReplyButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommentCrudProvider>(
      builder: (context, commentCrudProvider, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          ),
          onPressed: () {
            commentCrudProvider.onReplyPressed();
          },
          child: Row(
            children: [
              Icon(
                Icons.reply,
                size: 20,
                color: Color.fromRGBO(83, 87, 182, 1),
              ),
              SizedBox(width: 5),
              Text(
                "Reply",
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(83, 87, 182, 1),
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
