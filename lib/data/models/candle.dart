class CandleModel {
  final DateTime date;
  final double high;
  final double low;
  final double open;
  final double close;
  final double volume;

  CandleModel({
    required this.date,
    required this.high,
    required this.low,
    required this.open,
    required this.close,
    required this.volume,
  });

  CandleModel.fromJson(List<dynamic> json)
      : date = DateTime.fromMillisecondsSinceEpoch(json[0]),
        high = double.parse(json[2]),
        low = double.parse(json[3]),
        open = double.parse(json[1]),
        close = double.parse(json[4]),
        volume = double.parse(json[5]);
}
