import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/comment_provider.dart';

class Textbox extends StatefulWidget {
  const Textbox({super.key});

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        return SizedBox(
          height: 96,
          child: TextFormField(
            minLines: 4,
            maxLines: 4,
            controller: commentProvider.replyTextController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a reply.';
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
              hintText: 'Add a reply...',
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
        );
      },
    );
  }
}
