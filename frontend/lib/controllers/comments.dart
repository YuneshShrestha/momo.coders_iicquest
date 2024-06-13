import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_sathi/models/comment_model.dart';

class CommentsController {
  static Future<List<CommentModel>> fetchComments(String postsID) async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/api/posts/$postsID/comments/'));
    print("http://localhost:3000/api/posts/$postsID/comments/");
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => CommentModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<bool> addComment(
      {required String comment,
      required String postId,
      required String userId,
      required String userType}) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/comments'),
        body: json.encode({
          "comment": comment,
          "postId": postId,
          "userId": userId,
          "userType": userType,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('''{
          "comment": $comment,
          "postId": $postId,
          "userId": $userId,
          "userType": $userType,
        }''');
      print(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
