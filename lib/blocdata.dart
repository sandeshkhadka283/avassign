import 'dart:convert';
import 'package:http/http.dart' as http;

class DataBloc {
  Future<List<dynamic>> fetchData(String apiEndpoint) async {
    final response = await http.get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
