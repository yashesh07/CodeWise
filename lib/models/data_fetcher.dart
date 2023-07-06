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

// class DataFetcher {
//   Future<Album> fetchAlbum() async {
//     final response = await http
//         .get(Uri.parse('https://codeforces.com/api/contest.list?gym=false'));
//     if (response.statusCode == 200) {
//       return Album.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }
// }
//
// class Album {
//   String status;
//   List<Result> result;
//
//   Album({
//     required this.status,
//     required this.result
//   });
//
//   factory Album.fromJson(Map<String, dynamic> json) => Album(
//     status: json["status"],
//     result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "result": List<dynamic>.from(result.map((x) => x.toJson())),
//   };
// }
//
// class Result {
//   final int id;
//   final String name;
//   final String type;
//   final String phase;
//   final bool frozen;
//   final int durationSeconds;
//   final int startTimeSeconds;
//   final int relativeTimeSeconds;
//
//   const Result({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.phase,
//     required this.frozen,
//     required this.durationSeconds,
//     required this.startTimeSeconds,
//     required this.relativeTimeSeconds,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) {
//     return Result(
//         id: json['id'],
//         name: json['name'],
//         type: json['type'],
//         phase: json['phase'],
//         frozen: json['frozen'],
//         durationSeconds: json['durationSeconds'],
//         startTimeSeconds: json['startTimeSeconds'],
//         relativeTimeSeconds: json['relativeTimeSeconds']
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "type": type,
//   };
// }