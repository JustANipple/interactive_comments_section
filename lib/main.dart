import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interactive_comments_section/components/post_form.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'components/comments/list.dart';
import 'provider/comment_provider.dart';

Future<void> main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CommentProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
      builder: (context, commentProvider, child) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: const Color.fromRGBO(245, 246, 250, 1),
            body: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 375),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    (commentProvider.comments.isEmpty ||
                            commentProvider.users.isEmpty)
                        ? Center(child: const CircularProgressIndicator())
                        : CommentList(),
                    const PostForm(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}