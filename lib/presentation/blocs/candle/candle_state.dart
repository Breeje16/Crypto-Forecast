part of 'candle_cubit.dart';

abstract class CandleState extends Equatable {
  const CandleState();

  @override
  List<Object> get props => [];
}

class CandleInitial extends CandleState {}

class CandleLoaded extends CandleState {
  final List<CandleData> candle;

  const CandleLoaded(this.candle);

  @override
  List<Object> get props => [candle];
}

class CandleLoading extends CandleState {}

class CandleError extends CandleState {
  final AppError errorType;

  const CandleError(this.errorType);

  @override
  List<Object> get props => [errorType];
}
