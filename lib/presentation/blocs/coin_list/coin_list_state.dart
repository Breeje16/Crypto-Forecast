part of 'coin_list_bloc.dart';

abstract class CoinListState extends Equatable {
  const CoinListState();

  @override
  List<Object> get props => [];
}

class CoinListInitial extends CoinListState {}

class CoinListError extends CoinListState {}

class CoinListLoaded extends CoinListState {
  final List<CoinsEntity> coins;
  final int defaultIndex;

  const CoinListLoaded({
    required this.coins,
    this.defaultIndex = 0,
  }) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');

  @override
  List<Object> get props => [coins, defaultIndex];
}
