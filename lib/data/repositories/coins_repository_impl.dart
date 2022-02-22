import 'package:cryptoforecast/data/data_sources/coins_remote_data_source.dart';
import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/repositories/coins_repository.dart';
import 'package:cryptoforecast/data/models/coins_model.dart';
import 'package:dartz/dartz.dart';

class CoinsRepositoryImpl extends CoinsRepository {
  final CoinsRemoteDataSource remoteDataSource;

  CoinsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<Coins>>> fetchCoins() async {
    try {
      final coins = await remoteDataSource.fetchCoins();
      return Right(coins);
    } on Exception {
      return const Left(AppError('Something went wrong'));
    }
  }
}
