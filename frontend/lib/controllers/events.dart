import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_sathi/models/videos_model.dart';

class EventsController {
  // static Future<bool> postVideos(String name) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://localhost:3000/api/categories/'),
  //       body: json.encode({
  //         'name': name,
  //       }),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  static Future<List<EventsModel>> getVideos(String uid) async {
    print("Hello");
    final response = await http.get(
      Uri.parse(
        'http://localhost:3000/api/videos/user/$uid',
      ),
    );
    print('http://localhost:3000/api/videos/user/$uid');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => EventsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
