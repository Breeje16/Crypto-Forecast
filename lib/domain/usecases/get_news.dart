import 'package:cryptoforecast/data/models/news_query_model.dart';
import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/entities/news_params.dart';
import 'package:cryptoforecast/domain/repositories/news_repository.dart';
import 'package:cryptoforecast/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetNews extends UseCase<List<NewsQueryModel>, NewsParams> {
  final NewsRepository repository;

  GetNews(this.repository);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Either<AppError, List<NewsQueryModel>>> call(
      // ignore: avoid_renaming_method_parameters
      NewsParams newsParams) async {
    return await repository.getNews(newsParams.query);
  }
}
