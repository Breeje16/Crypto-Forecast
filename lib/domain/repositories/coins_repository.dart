import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/entities/coins_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CoinsRepository {
  Future<Either<AppError, List<CoinsEntity>>> fetchCoins();
}
