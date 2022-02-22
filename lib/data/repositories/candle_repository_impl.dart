import 'package:cryptoforecast/data/data_sources/candle_remote_date_source.dart';
import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/repositories/candle_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:interactive_chart/interactive_chart.dart';

class CandleRepositoryImpl extends CandleRepository {
  final CandleRemoteDataSource remoteDataSource;

  CandleRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<CandleData>>> getData(
      String coinid, String days) async {
    try {
      final data = await remoteDataSource.getData(coinid, days);
      return Right(data);
    } on Exception {
      return const Left(AppError('Something went wrong'));
    }
  }
}
