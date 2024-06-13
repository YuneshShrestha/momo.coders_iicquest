import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_sathi/models/comment_model.dart';

class CommentsController {
  static Future<bool> isValidComment(String comment) async {
    if (comment.isNotEmpty) {
      final response =
          await http.post(Uri.parse("http://127.0.0.1:5000/predict"),
              body: json.encode({
                "input": comment,
              }));

      bool contains0 = response.body.contains("0");
      if (contains0) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

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

  static Future<String> addComment(
      {required String comment,
      required String postId,
      required String userId,
      required String userType}) async {
    try {
      bool isValid = await isValidComment(comment);
      print("is valid $isValid");
      if (isValid) {
        return "No hate comments allowed.";
      }
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
        return "Comment added successfully";
      } else {
        return "Failed to add comment";
      }
    } catch (e) {
      return "Failed to add comment";
    }
  }
}
