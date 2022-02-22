import 'package:cryptoforecast/data/core/candle_api_client.dart';
import 'package:interactive_chart/interactive_chart.dart';

abstract class CandleRemoteDataSource {
  Future<List<CandleData>> getData(String coinid, String days);
}

class CandleRemoteDataSourceImpl extends CandleRemoteDataSource {
  final CandleApiClient _client;

  CandleRemoteDataSourceImpl(this._client);

  @override
  Future<List<CandleData>> getData(String coinid, String days) async {
    final response = await _client.get(coinid, days);
    var rawdata = List<CandleData>.empty(growable: true);

    if (response.length > 0) {
      for (int i = 0; i < response.length; i++) {
        if (response[i] != null) {
          response.forEach((v) {
            rawdata.add(CandleData(
              timestamp: v[0] * 1000,
              open: v[1]?.toDouble(),
              high: v[2]?.toDouble(),
              low: v[3]?.toDouble(),
              close: v[4]?.toDouble(),
              volume: 0,
            ));
          });
          // coinList.add(Coins.fromJson(map));
        }
      }
    }
    // List<CandleData> rawdata = response
    //     .map((row) => CandleData(
    //           timestamp: row[0] * 1000,
    //           open: row[1]?.toDouble(),
    //           high: row[2]?.toDouble(),
    //           low: row[3]?.toDouble(),
    //           close: row[4]?.toDouble(),
    //           volume: 0,
    //         ))
    //     .toList();

    return rawdata;
  }
}
