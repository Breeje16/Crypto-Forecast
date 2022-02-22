part of 'coin_list_bloc.dart';

abstract class CoinListEvent extends Equatable {
  const CoinListEvent();

  @override
  List<Object> get props => [];
}

class CoinsLoadEvent extends CoinListEvent {
  final int defaultIndex;

  const CoinsLoadEvent({this.defaultIndex = 0})
      : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');

  @override
  List<Object> get props => [defaultIndex];
}
