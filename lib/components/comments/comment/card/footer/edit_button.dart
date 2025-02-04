import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/comment_crud_provider.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

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
            commentCrudProvider.onEditPressed();
          },
          child: Row(
            children: [
              Icon(
                Icons.edit,
                size: 20,
                color: Color.fromRGBO(83, 87, 182, 1),
              ),
              SizedBox(width: 5),
              Text(
                "Edit",
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
