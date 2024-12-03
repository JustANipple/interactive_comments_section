import 'package:flutter/material.dart';
import 'package:interactive_comments_section/components/post_form/textbox.dart';
import 'package:provider/provider.dart';

import '../provider/comment_provider.dart';
import 'post_form/send_button.dart';

class PostForm extends StatelessWidget {
  const PostForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Textbox(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Image(
                      image: AssetImage("assets/avatars/image-juliusomo.png"),
                      width: 32,
                      height: 32,
                    ),
                    SendButton(formKey: formKey),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}