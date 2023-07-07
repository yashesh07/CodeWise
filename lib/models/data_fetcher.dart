import 'dart:convert';

import 'package:http/http.dart' as http;


class DataFetcher {
  DataFetcher(this.url);
  final String url;
  Future<dynamic> fetchAlbum() async {
    final response = await http
        .get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}