import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/comment.dart';
import '../../../../provider/comment_provider.dart';

class CommentCardBodyEdit extends StatelessWidget {
  final int id;

  const CommentCardBodyEdit({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Textbox(id: id),
          ),
        );
      },
    );
  }
}

class Textbox extends StatefulWidget {
  final int? id;

  const Textbox({super.key, required this.id});

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        Comment comment = commentProvider.comments.firstWhere((value) => value.id == widget.id);
        commentProvider.editTextController.text = comment.text;
        return Form(
          key: commentProvider.editFormKey,
          child: SizedBox(
            height: 96,
            child: TextFormField(
              minLines: 4,
              maxLines: 4,
              controller: commentProvider.editTextController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a comment.';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(233, 235, 240, 1),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(233, 235, 240, 1),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(233, 235, 240, 1),
                  ),
                ),
                hintText: 'Add a comment...',
                hintStyle: GoogleFonts.rubik(
                  color: const Color.fromRGBO(103, 114, 126, 1),
                  height: 2.4,
                ),
              ),
              style: GoogleFonts.rubik(
                color: const Color.fromRGBO(103, 114, 126, 1),
              ),
              cursorColor: const Color.fromRGBO(103, 114, 126, 1),
              cursorHeight: 24,
            ),
          ),
        );
      },
    );
  }
}
