import 'package:cryptoforecast/data/data_sources/news_remote_data_source.dart';
import 'package:cryptoforecast/data/models/news_query_model.dart';
import 'package:cryptoforecast/domain/entities/app_error.dart';
import 'package:cryptoforecast/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<NewsQueryModel>>> getNews(String query) async {
    try {
      final news = await remoteDataSource.getNews(query);
      return Right(news);
    } on Exception {
      return const Left(AppError('Something went wrong'));
    }
  }
}
