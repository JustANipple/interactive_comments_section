import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/comment_provider.dart';
import 'card/reply_form/reply_button.dart';
import 'card/reply_form/textbox.dart';

class ReplyForm extends StatelessWidget {
  final int? parentId;

  const ReplyForm({super.key, this.parentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.only(top: 16),
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
                    ReplyButton(formKey: formKey, parentId: parentId),
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
