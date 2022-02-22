import 'package:cryptoforecast/data/models/news_query_model.dart';
import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<AppError, List<NewsQueryModel>>> getNews(String query);
}
