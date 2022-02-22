import 'package:equatable/equatable.dart';

class GetDataParams extends Equatable {
  final String coinid;
  final String days;

  const GetDataParams({required this.coinid, required this.days});

  @override
  List<Object> get props => [coinid, days];
}
