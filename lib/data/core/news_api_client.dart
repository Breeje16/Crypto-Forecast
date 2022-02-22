import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';

class NewsApiClient {
  final Client _client;

  NewsApiClient(this._client);

  dynamic get(String query) async {
    final response = await _client.get(
      Uri.parse(ApiConstants.newsApiBaseURL +
          'q=$query&apiKey=' +
          ApiConstants.newsBaseApiKey),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
