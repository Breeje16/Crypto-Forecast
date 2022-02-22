import 'package:cryptoforecast/data/models/coins_model.dart';

class CoinsResultModel {
  final List<Coins> coins;

  CoinsResultModel({required this.coins});

  factory CoinsResultModel.fromJson(Map<String, dynamic> json) {
    var data = List<Coins>.empty(growable: true);
    if (json.isNotEmpty) {
      for (int i = 0; i < json.length; i++) {
        if (json[i] != null) {
          Map<String, dynamic> map = json[i];
          data.add(Coins.fromJson(map));
        }
      }
    }
    return CoinsResultModel(coins: data);
  }
}
