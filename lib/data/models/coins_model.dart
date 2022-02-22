// ignore_for_file: annotate_overrides, overridden_fields, prefer_void_to_null, prefer_collection_literals

import 'package:cryptoforecast/domain/entities/coins_entity.dart';

class Coins extends CoinsEntity {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final double marketCapRank;
  final double fullyDilutedValuation;
  final double totalVolume;
  final double high24h;
  final double low24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double marketCapChange24h;
  final double marketCapChangePercentage24h;
  final double circulatingSupply;
  final double totalSupply;
  final double maxSupply;
  final double ath;
  final double athChangePercentage;
  final String athDate;
  final double atl;
  final double atlChangePercentage;
  final String atlDate;
  final String lastUpdated;

  const Coins(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice,
      required this.marketCap,
      required this.marketCapRank,
      required this.fullyDilutedValuation,
      required this.totalVolume,
      required this.high24h,
      required this.low24h,
      required this.priceChange24h,
      required this.priceChangePercentage24h,
      required this.marketCapChange24h,
      required this.marketCapChangePercentage24h,
      required this.circulatingSupply,
      required this.totalSupply,
      required this.maxSupply,
      required this.ath,
      required this.athChangePercentage,
      required this.athDate,
      required this.atl,
      required this.atlChangePercentage,
      required this.atlDate,
      required this.lastUpdated})
      : super(
          id: id,
          name: name,
          symbol: symbol,
          imageUrl: image,
          price: currentPrice,
          changePercentage: priceChangePercentage24h,
          marketCap: marketCap,
          circulatingSupply: circulatingSupply,
          maxSupply: maxSupply,
          totalVolume: totalVolume,
        );

  factory Coins.fromJson(Map<String, dynamic> json) {
    return Coins(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price']?.toDouble() ?? 0.0,
      marketCap: json['market_cap']?.toDouble() ?? 0.0,
      marketCapRank: json['market_cap_rank']?.toDouble() ?? 0.0,
      fullyDilutedValuation: json['fully_diluted_valuation']?.toDouble() ?? 0.0,
      totalVolume: json['total_volume']?.toDouble() ?? 0.0,
      high24h: json['high_24h']?.toDouble() ?? 0.0,
      low24h: json['low_24h']?.toDouble() ?? 0.0,
      priceChange24h: json['price_change_24h']?.toDouble() ?? 0.0,
      priceChangePercentage24h:
          json['price_change_percentage_24h']?.toDouble() ?? 0.0,
      marketCapChange24h: json['market_cap_change_24h']?.toDouble() ?? 0.0,
      marketCapChangePercentage24h:
          json['market_cap_change_percentage_24h']?.toDouble() ?? 0.0,
      circulatingSupply: json['circulating_supply']?.toDouble() ?? 0.0,
      totalSupply: json['total_supply']?.toDouble() ?? 0.0,
      maxSupply: json['max_supply']?.toDouble() ?? 0.0,
      ath: json['ath']?.toDouble() ?? 0.0,
      athChangePercentage: json['ath_change_percentage']?.toDouble() ?? 0.0,
      athDate: json['ath_date'],
      atl: json['atl']?.toDouble() ?? 0.0,
      atlChangePercentage: json['atl_change_percentage']?.toDouble() ?? 0.0,
      atlDate: json['atl_date'],
      lastUpdated: json['last_updated'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['image'] = image;
    data['current_price'] = currentPrice;
    data['market_cap'] = marketCap;
    data['market_cap_rank'] = marketCapRank;
    data['fully_diluted_valuation'] = fullyDilutedValuation;
    data['total_volume'] = totalVolume;
    data['high_24h'] = high24h;
    data['low_24h'] = low24h;
    data['price_change_24h'] = priceChange24h;
    data['price_change_percentage_24h'] = priceChangePercentage24h;
    data['market_cap_change_24h'] = marketCapChange24h;
    data['market_cap_change_percentage_24h'] = marketCapChangePercentage24h;
    data['circulating_supply'] = circulatingSupply;
    data['total_supply'] = totalSupply;
    data['max_supply'] = maxSupply;
    data['ath'] = ath;
    data['ath_change_percentage'] = athChangePercentage;
    data['ath_date'] = athDate;
    data['atl'] = atl;
    data['atl_change_percentage'] = atlChangePercentage;
    data['atl_date'] = atlDate;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
