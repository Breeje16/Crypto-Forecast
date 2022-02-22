import 'package:bloc/bloc.dart';
import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/entities/get_data_param.dart';
import 'package:cryptoforecast/domain/usecases/get_data.dart';
import 'package:cryptoforecast/presentation/blocs/loading/loading_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:interactive_chart/interactive_chart.dart';

part 'candle_state.dart';

class CandleCubit extends Cubit<CandleState> {
  final GetData getData;
  final LoadingCubit loadingCubit;

  CandleCubit({
    required this.getData,
    required this.loadingCubit,
  }) : super(CandleInitial());

  Future<void> getCandleData(String coinid, String days) async {
    loadingCubit.show();
    emit(CandleLoading());
    final Either<AppError, List<CandleData>> response =
        await getData(GetDataParams(coinid: coinid, days: days));
    emit(response.fold(
      (l) => CandleError(l),
      (r) => CandleLoaded(r),
    ));
    loadingCubit.hide();
  }
}
