import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('John Doe'),
            Chip(label: Text('Cat')),
          ],
        ),
        subtitle: Text('This is a post. Lorem ipsum dolor sit amet. '),
      ),
    );
  }
}
