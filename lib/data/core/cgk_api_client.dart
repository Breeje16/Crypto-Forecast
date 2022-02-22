import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';

class CGKApiClient {
  final Client _client;

  CGKApiClient(this._client);

  dynamic get() async {
    final response = await _client.get(
      Uri.parse(ApiConstants.coinFetchURL),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
