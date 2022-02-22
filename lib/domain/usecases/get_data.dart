import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/entities/get_data_param.dart';
import 'package:cryptoforecast/domain/repositories/candle_repository.dart';
import 'package:cryptoforecast/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:interactive_chart/interactive_chart.dart';

class GetData extends UseCase<List<CandleData>, GetDataParams> {
  final CandleRepository repository;

  GetData(this.repository);

  @override
  Future<Either<AppError, List<CandleData>>> call(
      // ignore: avoid_renaming_method_parameters
      GetDataParams getDataParams) async {
    return await repository.getData(getDataParams.coinid, getDataParams.days);
  }
}
