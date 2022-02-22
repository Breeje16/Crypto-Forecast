import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/entities/coins_entity.dart';
import 'package:cryptoforecast/domain/entities/no_params.dart';
import 'package:cryptoforecast/domain/repositories/coins_repository.dart';
import 'package:cryptoforecast/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchCoins extends UseCase<List<CoinsEntity>, NoParams> {
  final CoinsRepository repository;

  FetchCoins(this.repository);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Either<AppError, List<CoinsEntity>>> call(NoParams noParams) async {
    return await repository.fetchCoins();
  }
}
