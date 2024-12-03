import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interactive_comments_section/provider/comment_crud_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/comment_provider.dart';


class ReplyButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final int? parentId;

  const ReplyButton({super.key, required this.formKey,  required this.parentId});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommentProvider, CommentCrudProvider>(
      builder: (context, commentProvider, commentCrudProvider, child) {
        return ElevatedButton(
          onPressed: () {
            commentProvider.submitReply(context, formKey, parentId);
            commentCrudProvider.onReplyPressed();
          },
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(
              Color.fromRGBO(83, 87, 182, 1),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 30, vertical: 13),
            ),
          ),
          child: Text(
            "REPLY",
            style: GoogleFonts.rubik(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 2.4,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
