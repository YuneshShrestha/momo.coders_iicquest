import 'package:http/http.dart' as http;

class PromptController {
  static Future<String> fetchComments(String prompt) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/answer?prompt=$prompt'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
