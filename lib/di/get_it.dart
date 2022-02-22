import 'package:cryptoforecast/data/core/candle_api_client.dart';
import 'package:cryptoforecast/data/core/cgk_api_client.dart';
import 'package:cryptoforecast/data/core/news_api_client.dart';
import 'package:cryptoforecast/data/data_sources/candle_remote_date_source.dart';
import 'package:cryptoforecast/data/data_sources/coins_remote_data_source.dart';
import 'package:cryptoforecast/data/data_sources/news_remote_data_source.dart';
import 'package:cryptoforecast/data/repositories/candle_repository_impl.dart';
import 'package:cryptoforecast/data/repositories/coins_repository_impl.dart';
import 'package:cryptoforecast/data/repositories/news_repository_impl.dart';
import 'package:cryptoforecast/domain/repositories/candle_repository.dart';
import 'package:cryptoforecast/domain/repositories/coins_repository.dart';
import 'package:cryptoforecast/domain/repositories/news_repository.dart';
import 'package:cryptoforecast/domain/usecases/fetch_coins.dart';
import 'package:cryptoforecast/domain/usecases/get_data.dart';
import 'package:cryptoforecast/domain/usecases/get_news.dart';
import 'package:cryptoforecast/presentation/blocs/candle/candle_cubit.dart';
import 'package:cryptoforecast/presentation/blocs/coin_list/coin_list_bloc.dart';
import 'package:cryptoforecast/presentation/blocs/loading/loading_cubit.dart';
import 'package:cryptoforecast/presentation/blocs/news/news_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getItInstance = GetIt.I;

Future init() async {
  //----------------------- API CLIENTS -----------------------------------

  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<CGKApiClient>(() => CGKApiClient(getItInstance()));

  getItInstance.registerLazySingleton<CandleApiClient>(
      () => CandleApiClient(getItInstance()));

  getItInstance.registerLazySingleton<NewsApiClient>(
      () => NewsApiClient(getItInstance()));

  //----------------------- DATA SOURCES -----------------------------------

  getItInstance.registerLazySingleton<CoinsRemoteDataSource>(
      () => CoinsRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<CandleRemoteDataSource>(
      () => CandleRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(getItInstance()));

  //----------------------- USECASES -----------------------------------

  getItInstance
      .registerLazySingleton<FetchCoins>(() => FetchCoins(getItInstance()));

  getItInstance.registerLazySingleton<GetData>(() => GetData(getItInstance()));

  getItInstance.registerLazySingleton<GetNews>(() => GetNews(getItInstance()));

  //----------------------- REPOS -----------------------------------

  getItInstance.registerLazySingleton<CoinsRepository>(
      () => CoinsRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<CandleRepository>(
      () => CandleRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(getItInstance()));

  //----------------------- BLOCS AND CUBITS -----------------------------------

  getItInstance.registerFactory(
    () => CoinListBloc(
      fetchCoins: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => CandleCubit(
      loadingCubit: getItInstance(),
      getData: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => NewsCubit(
      loadingCubit: getItInstance(),
      getNews: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
}
