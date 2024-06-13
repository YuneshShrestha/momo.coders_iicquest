import 'dart:math';

import 'package:flutter/material.dart';
import 'package:virtual_sathi/controllers/comments.dart';
import 'package:virtual_sathi/models/comment_model.dart';
import 'package:virtual_sathi/widgets/post_widget.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.widget,
    required this.isAnonymous,
  });

  final PostWidget widget;
  final bool isAnonymous;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late List<CommentModel> comments;
  bool isLoading = false;
  TextEditingController commentController = TextEditingController();
  late int votes;
  @override
  void initState() {
    votes = Random().nextInt(10);
    getComments();
    super.initState();
  }

  Future<void> getComments() async {
    setState(() {
      isLoading = true;
    });
    comments = await CommentsController.fetchComments(
        widget.widget.postModel.id ?? 'No id');

    print(comments.length);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            height: 300,
            width: 400,
            child: Column(
              children: [
                const Flexible(
                  flex: 1,
                  child: Text('Comment'),
                ),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(comments[
                                                      index]
                                                  .userType ==
                                              "ANONYMOUS"
                                          ? "https://seeklogo.com/images/A/anonymous-logo-7E968E8797-seeklogo.com.png"
                                          : "https://png.pngtree.com/png-clipart/20240101/original/pngtree-therapist-icon-healthcare-photo-png-image_13990010.png"),
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(":",
                                        style: TextStyle(fontSize: 20)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comments[index].comment ??
                                              'No user id',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            votes++;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.keyboard_arrow_up_rounded)),
                                    Column(
                                      children: [
                                        Text(
                                          votes.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          "Votes",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            votes--;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 4,
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              labelText: 'Comment',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextButton(
                            onPressed: () async {
                              final isAdded =
                                  await CommentsController.addComment(
                                comment: commentController.text,
                                postId: widget.widget.postModel.id ?? 'No id',
                                userId: widget.widget.postModel.userId ??
                                    'No user id',
                                userType: widget.isAnonymous
                                    ? 'ANONYMOUS'
                                    : 'THERAPIST',
                              );

                              if (context.mounted && isAdded) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Comment added successfully'),
                                  ),
                                  // Refresh the comments
                                );
                                await getComments();
                                // Navigator.of(context).pop();
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Failed to add comment'),
                                    ),
                                  );
                                }
                              }
                              commentController.clear();
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
