import 'package:bloc/bloc.dart';
import 'package:cryptoforecast/domain/entities/coins_entity.dart';
import 'package:cryptoforecast/domain/entities/no_params.dart';
import 'package:cryptoforecast/domain/usecases/fetch_coins.dart';
import 'package:equatable/equatable.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  final FetchCoins fetchCoins;

  CoinListBloc({
    required this.fetchCoins,
  }) : super(CoinListInitial());

  @override
  Stream<CoinListState> mapEventToState(
    CoinListEvent event,
  ) async* {
    if (event is CoinsLoadEvent) {
      final coinsEither = await fetchCoins(NoParams());
      yield coinsEither.fold(
        (l) => CoinListError(),
        (coins) {
          return CoinListLoaded(
            coins: coins,
            defaultIndex: event.defaultIndex,
          );
        },
      );
    }
  }
}
