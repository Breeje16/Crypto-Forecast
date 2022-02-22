part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsQueryModel> news;

  const NewsLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class NewsLoading extends NewsState {}

class NewsError extends NewsState {
  final AppError errorType;

  const NewsError(this.errorType);

  @override
  List<Object> get props => [errorType];
}
