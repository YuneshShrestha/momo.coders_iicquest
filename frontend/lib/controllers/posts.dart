import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_sathi/models/post_model.dart';

class PostsController {
  static Future<List<PostModel>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/posts/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<bool> addPost(
      {required String title,
      required String description,
      required String userId}) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/posts/'),
        body: json.encode({
          'title': title,
          'description': description,
          'userId': userId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
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
