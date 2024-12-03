import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../models/comment.dart';
import '../../../../../provider/comment_provider.dart';

class Likes extends StatelessWidget {
  final int? id;

  const Likes({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        final Comment comment = commentProvider.getCommentById(id!);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(245, 246, 250, 1),
          ),
          constraints: BoxConstraints(maxWidth: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: ElevatedButton(
                  onPressed: () {
                    commentProvider.addLike(id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.all(0),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 15,
                    color: Color.fromRGBO(197, 198, 239, 1),
                  ),
                ),
              ),
              Text(
                comment.likes.toString(),
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(83, 87, 182, 1),
                ),
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: ElevatedButton(
                  onPressed: () {
                    commentProvider.removeLike(id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.all(0),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 15,
                    color: Color.fromRGBO(197, 198, 239, 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
