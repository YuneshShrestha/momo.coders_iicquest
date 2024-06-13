import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:virtual_sathi/models/post_model.dart';
import 'package:virtual_sathi/widgets/comment_widget.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.postModel, this.isLast = false});
  final PostModel postModel;
  final bool isLast;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLoading = false;
  TextEditingController commentController = TextEditingController();
  bool isAnonymous = false;
  String userId = '';

  @override
  void initState() {
    isAnonymousUser().then((value) {
      setState(() {
        isAnonymous = value;
      });
    });
    getUserID().then((value) {
      setState(() {
        userId = value;
      });
    });
    super.initState();
  }

  Future<bool> isAnonymousUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.isAnonymous;
    }
    return false;
  }

  Future<String> getUserID() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return '';
  }

  bool isCommentLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://seeklogo.com/images/A/anonymous-logo-7E968E8797-seeklogo.com.png"),
              radius: 20,
            ),
            // Make a horizontal line
            Container(
              height: 50,
              width: 2,
              color: Colors.white,
            ),
            const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 5,
            ),
            SizedBox(
              height: widget.isLast ? 0 : 50,
              width: 2,
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.postModel.title ?? 'No title',
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text('2070/12/01',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic)),
                  Text(
                    widget.postModel.description ?? 'No description',
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
              child: FittedBox(
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return CommentWidget(
                                    widget: widget, isAnonymous: isAnonymous);
                              },
                            ),
                          );
                        });
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('3 comments'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
