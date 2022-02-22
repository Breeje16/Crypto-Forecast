import 'package:cryptoforecast/data/core/cgk_api_client.dart';
import 'package:cryptoforecast/data/models/coins_model.dart';

abstract class CoinsRemoteDataSource {
  Future<List<Coins>> fetchCoins();
}

class CoinsRemoteDataSourceImpl extends CoinsRemoteDataSource {
  final CGKApiClient _client;

  CoinsRemoteDataSourceImpl(this._client);

  set coinList(List coinList) {}

  @override
  Future<List<Coins>> fetchCoins() async {
    final response = await _client.get(); //VALUES = RESPONSE
    var coinList = List<Coins>.empty(growable: true);
    if (response.length > 0) {
      for (int i = 0; i < response.length; i++) {
        if (response[i] != null) {
          // Map<String, dynamic> map = response[i];
          response.forEach((v) {
            coinList.add(Coins.fromJson(v));
          });
          // coinList.add(Coins.fromJson(map));
        }
      }
    }
    // final coinsData = CoinsResultModel.fromJson(response).coins;
    return coinList;
  }
}
