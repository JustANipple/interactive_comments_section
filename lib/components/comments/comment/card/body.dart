import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/comment.dart';
import '../../../../provider/comment_provider.dart';

class CommentCardBody extends StatelessWidget {
  final int? id;

  const CommentCardBody({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        final Comment comment = commentProvider.getCommentById(id!);
        final String text = comment.text;

        final List<String> words = text.split(' ');

        return Text.rich(
          TextSpan(
            children: words.map((word) {
              final bool isMention = word.contains('@');
              return TextSpan(
                text: '$word ',
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: isMention ? FontWeight.w600 : FontWeight.normal,
                  color: isMention
                      ? Color.fromRGBO(83, 87, 182, 1)
                      : Color.fromRGBO(103, 114, 126, 1),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
