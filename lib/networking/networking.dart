// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String urlLink;
  NetworkHelper({required this.urlLink});

  Future getData() async {
    var url = Uri.parse(urlLink);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else if (response.statusCode == 404) {
      print("Status Code is: ${response.statusCode}");
    } else {
      print("Status Code is: ${response.statusCode}");
    }
  }
}
