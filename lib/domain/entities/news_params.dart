import 'package:equatable/equatable.dart';

class NewsParams extends Equatable {
  final String query;

  const NewsParams({required this.query});

  @override
  List<Object> get props => [query];
}
