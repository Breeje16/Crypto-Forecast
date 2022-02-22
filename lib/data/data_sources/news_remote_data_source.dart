import 'package:cryptoforecast/data/core/news_api_client.dart';
import 'package:cryptoforecast/data/models/news_query_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsQueryModel>> getNews(String query);
}

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  final NewsApiClient _client;

  NewsRemoteDataSourceImpl(this._client);

  @override
  Future<List<NewsQueryModel>> getNews(String query) async {
    Map response = await _client.get(query);
    List<NewsQueryModel> newsQueryResults = <NewsQueryModel>[];
    response["articles"].forEach((element) {
      NewsQueryModel newsQueryModel = NewsQueryModel.fromMap(element);
      newsQueryResults.add(newsQueryModel);
    });

    return newsQueryResults;
  }
}
