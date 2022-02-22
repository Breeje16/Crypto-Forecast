import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';

class CandleApiClient {
  final Client _client;

  CandleApiClient(this._client);

  dynamic get(String coinid, String days) async {
    final response = await _client.get(
      Uri.parse(ApiConstants.candleFetchBaseURL +
          '$coinid/ohlc?vs_currency=usd&days=$days'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
