import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    if (commentProvider.users.isNotEmpty)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          showModal(context);
                        },
                        child: Image(
                          image: AssetImage(commentProvider.users
                              .where((value) =>
                                  value.id == commentProvider.userAddId)
                              .first
                              .avatarImageUrl),
                          width: 32,
                          height: 32,
                        ),
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

void showModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          'Change user',
          style: GoogleFonts.rubik(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(51, 66, 83, 1)),
        ),
        content: Consumer<CommentProvider>(
            builder: (context, commentProvider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select the user you want to log in with',
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                  color: Color.fromRGBO(103, 114, 126, 1),
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < commentProvider.users.length; i++)
                    ListTile(
                      title: Row(
                        children: [
                          Image(
                            image: AssetImage(
                                commentProvider.users[i].avatarImageUrl),
                            width: 32,
                            height: 32,
                          ),
                          SizedBox(width: 8),
                          Text(
                            commentProvider.users[i].name,
                            style: GoogleFonts.rubik(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 63, 83, 1),
                            ),
                          ),
                          SizedBox(width: 8),
                          if (commentProvider.userAddId ==
                              commentProvider.users[i].id)
                            Container(
                              padding: EdgeInsets.fromLTRB(6, 2, 6, 4),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(83, 87, 182, 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "you",
                                    style: GoogleFonts.rubik(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        commentProvider.setUser(commentProvider.users[i].id);
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              )
            ],
          );
        }),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(103, 114, 126, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  child: Text(
                    "CANCEL",
                    style: GoogleFonts.rubik(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      );
    },
  );
}
