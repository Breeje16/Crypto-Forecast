// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';

import 'package:cryptoforecast/domain/entities/coins_entity.dart';
import 'package:cryptoforecast/presentation/themes/colorz.dart';
import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class CoinDetailScreen extends StatefulWidget {
  final CoinsEntity coin;
  // ignore: use_key_in_widget_constructors
  const CoinDetailScreen({required this.coin});

  @override
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  List<Candle> candles = [];
  WebSocketChannel? _channel;
  bool isLoading = true;

  String interval = "1m";

  Future<List<Candle>> fetchCandles(
      {required String symbol, required String interval}) async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=1000");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  void binanceFetch(String interval) {
    String cid = widget.coin.id.toUpperCase();
    fetchCandles(symbol: cid + "USDT", interval: interval).then(
      (value) => setState(
        () {
          this.interval = interval;
          candles = value;
        },
      ),
    );
    _channel?.sink.close();
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );
    _channel?.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": [cid.toLowerCase() + "usdt@kline_" + interval],
          "id": 1
        },
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    binanceFetch("1m");
    super.initState();
  }

  @override
  void dispose() {
    _channel!.sink.close();
    super.dispose();
  }

  void updateCandlesFromSnapshot(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.data != null) {
      final data = jsonDecode(snapshot.data as String) as Map<String, dynamic>;
      if (data.containsKey("k") == true &&
          candles[0].date.millisecondsSinceEpoch == data["k"]["t"]) {
        candles[0] = Candle(
            date: candles[0].date,
            high: double.parse(data["k"]["h"]),
            low: double.parse(data["k"]["l"]),
            open: double.parse(data["k"]["o"]),
            close: double.parse(data["k"]["c"]),
            volume: double.parse(data["k"]["v"]));
      } else if (data.containsKey("k") == true &&
          data["k"]["t"] - candles[0].date.millisecondsSinceEpoch ==
              candles[0].date.millisecondsSinceEpoch -
                  candles[1].date.millisecondsSinceEpoch) {
        candles.insert(
            0,
            Candle(
                date: DateTime.fromMillisecondsSinceEpoch(data["k"]["t"]),
                high: double.parse(data["k"]["h"]),
                low: double.parse(data["k"]["l"]),
                open: double.parse(data["k"]["o"]),
                close: double.parse(data["k"]["c"]),
                volume: double.parse(data["k"]["v"])));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorz.currenciesPageBackground,
      appBar: AppBar(
        backgroundColor: Colorz.currenciesPageBackground,
        title: Text(
          widget.coin.name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? Container(
              height: 200,
              child: const Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.coin.imageUrl,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Text(
                      widget.coin.name + ' (' + widget.coin.id + ')',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colorz.currenciesNameColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                          (candles.first.close - candles.first.open < 0)
                              ? Icons.trending_down
                              : Icons.trending_up,
                          color: (candles.first.close - candles.first.open < 0)
                              ? Colors.red
                              : Colorz.currencyPositiveGreen),
                    ),
                    Text(
                      "\$" + candles.first.close.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white, //CHANGED
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: StreamBuilder(
                      // ignore: prefer_null_aware_operators, unnecessary_null_comparison
                      stream: _channel == null ? null : _channel?.stream,
                      builder: (context, snapshot) {
                        updateCandlesFromSnapshot(snapshot);
                        return Candlesticks(
                          onIntervalChange: (String value) async {
                            binanceFetch(value);
                          },
                          candles: candles,
                          interval: interval,
                        );
                      },
                    ),
                  ),
                ),
                Column(),
                Container(
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 400.0,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Circulating Supply: ",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  widget.coin.circulatingSupply.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Max Supply: ",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  widget.coin.maxSupply.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Total Volume: ",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  widget.coin.totalVolume.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Market Cap: ",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  widget.coin.marketCap.toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
