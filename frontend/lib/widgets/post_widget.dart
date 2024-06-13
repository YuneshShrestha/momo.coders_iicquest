import 'package:flutter/material.dart';
import 'package:virtual_sathi/models/post_model.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.postModel, this.isLast = false});
  final PostModel postModel;
  final bool isLast;

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
              height: isLast ? 0 : 50,
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
                    postModel.title ?? 'No title',
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text('2070/12/01',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic)),
                  Text(
                    postModel.description ?? 'No description',
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: TextButton(
                onPressed: () {},
                child: const Text('3 comments'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
