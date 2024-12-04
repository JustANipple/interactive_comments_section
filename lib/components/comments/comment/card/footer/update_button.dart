import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/comment_crud_provider.dart';
import '../../../../../provider/comment_provider.dart';

class UpdateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final int? id;

  const UpdateButton({super.key, required this.formKey, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommentProvider, CommentCrudProvider>(
      builder: (context, commentProvider, commentCrudProvider, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          ),
          onPressed: () {
            commentProvider.submitEdit(context, formKey, id);
            commentCrudProvider.onEditPressed();
          },
          child: Row(
            children: [
              Icon(
                Icons.upload,
                size: 20,
                color: Color.fromRGBO(83, 87, 182, 1),
              ),
              SizedBox(width: 5),
              Text(
                "Update",
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
