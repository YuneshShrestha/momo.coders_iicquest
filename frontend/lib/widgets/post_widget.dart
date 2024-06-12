import 'package:flutter/material.dart';
import 'package:virtual_sathi/models/post_model.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.postModel});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(postModel.title ?? ''),
            Chip(label: Text('Cat')),
          ],
        ),
        subtitle: Text(postModel.description ?? ''),
      ),
    );
  }
}
