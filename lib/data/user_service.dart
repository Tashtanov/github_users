import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {
  Future<List<dynamic>> fetchUsers(int page) async {
    try {
      final response = await http
          .get(Uri.parse('https://api.github.com/users?per_page=${page}'));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      return [];
    }
  }
}
