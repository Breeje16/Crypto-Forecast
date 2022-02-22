class ApiConstants {
  ApiConstants._();

  static const String coinFetchURL =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  static const String candleFetchBaseURL =
      "https://api.coingecko.com/api/v3/coins/";
  static const String newsApiBaseURL = "https://newsapi.org/v2/everything?";
  // static const String newsAPIKEY = "9bb7bf6152d147ad8ba14cd0e7452f2f";
  static const String newsBaseApiKey = "fa5a44f3924f496ab548710fd4e17fe2";
  static const String cmcAPIKEY = "bf84a5f4-228f-40e9-885b-77323ac3b964";
}
