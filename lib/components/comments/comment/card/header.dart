import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/comment.dart';
import '../../../../models/user.dart';
import '../../../../provider/comment_provider.dart';

class CommentCardHeader extends StatefulWidget {
  final Comment comment;
  final User user;

  const CommentCardHeader(
      {super.key, required this.comment, required this.user});

  @override
  State<CommentCardHeader> createState() => _CommentCardHeaderState();
}

class _CommentCardHeaderState extends State<CommentCardHeader> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
        builder: (context, commentProvider, child) {
      return Row(
        children: [
          Image(
            image: AssetImage(widget.user.avatarImageUrl),
            width: 32,
            height: 32,
          ),
          SizedBox(width: 16),
          Row(
            children: [
              Text(
                widget.user.name,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(51, 63, 83, 1),
                ),
              ),
              SizedBox(width: 8),
              if (commentProvider.userAddId == widget.comment.userAddId)
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
          SizedBox(width: 16),
          Text(
            CommentProvider.calculatePastTime(widget.comment),
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              height: 2.4,
              color: Color.fromRGBO(103, 114, 126, 1),
            ),
          ),
        ],
      );
    });
  }
}
