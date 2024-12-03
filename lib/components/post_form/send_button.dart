import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/comment_provider.dart';

class SendButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SendButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        return ElevatedButton(
          onPressed: () {
            commentProvider.submitComment(context, formKey);
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
            "SEND",
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
