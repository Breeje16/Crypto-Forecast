import 'package:equatable/equatable.dart';

class CoinsEntity extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final num marketCap;
  final num circulatingSupply;
  final num maxSupply;
  final num totalVolume;
  final num price;
  final num changePercentage;

  const CoinsEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.changePercentage,
    required this.marketCap,
    required this.circulatingSupply,
    required this.maxSupply,
    required this.totalVolume,
  });

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;
}
