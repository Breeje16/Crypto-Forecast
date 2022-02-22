import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:interactive_chart/interactive_chart.dart';

abstract class CandleRepository {
  Future<Either<AppError, List<CandleData>>> getData(
      String coinid, String days);
}
