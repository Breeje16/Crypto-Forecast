import 'dart:async';

import 'package:cryptoforecast/di/get_it.dart';
import 'package:cryptoforecast/domain/entities/get_data_param.dart';
import 'package:cryptoforecast/presentation/blocs/candle/candle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_chart/interactive_chart.dart';

// ignore: must_be_immutable
class ChartScreen extends StatefulWidget {
  String coinid;
  ChartScreen({
    Key? key,
    required this.coinid,
  }) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late List<CandleData> _data;
  late CandleCubit candleCubit;
  bool _showAverage = false;
  String days = "1";

  @override
  void initState() {
    super.initState();
    candleCubit = getItInstance<CandleCubit>();
    candleCubit.getData(GetDataParams(coinid: widget.coinid, days: days));

    Timer.periodic(
        const Duration(seconds: 20),
        (timer) => candleCubit
            .getData(GetDataParams(coinid: widget.coinid, days: days)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chart"),
        actions: [
          IconButton(
            icon: Icon(
              _showAverage ? Icons.show_chart : Icons.bar_chart_outlined,
            ),
            onPressed: () {
              setState(() => _showAverage = !_showAverage);
              if (_showAverage) {
                _computeTrendLines();
              } else {
                _removeTrendLines();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<CandleCubit, CandleState>(
        bloc: candleCubit,
        builder: (context, state) {
          if (state is CandleError) {
            return const Center(
              child: Text('Data Currently Unavailable.. Please Try Later!'),
            );
          } else if (state is CandleLoaded) {
            _data = state.candle;
            return SafeArea(
              minimum: const EdgeInsets.all(24.0),
              child: InteractiveChart(
                /** Only [candles] is required */
                candles: _data,
                /** Uncomment the following for examples on optional parameters */

                /** Example styling */
                // style: ChartStyle(
                //   priceGainColor: Colors.teal[200]!,
                //   priceLossColor: Colors.blueGrey,
                //   volumeColor: Colors.teal.withOpacity(0.8),
                //   trendLineStyles: [
                //     Paint()
                //       ..strokeWidth = 2.0
                //       ..strokeCap = StrokeCap.round
                //       ..color = Colors.deepOrange,
                //     Paint()
                //       ..strokeWidth = 4.0
                //       ..strokeCap = StrokeCap.round
                //       ..color = Colors.orange,
                //   ],
                //   priceGridLineColor: Colors.blue[200]!,
                //   priceLabelStyle: TextStyle(color: Colors.blue[200]),
                //   timeLabelStyle: TextStyle(color: Colors.blue[200]),
                //   selectionHighlightColor: Colors.red.withOpacity(0.2),
                //   overlayBackgroundColor: Colors.red[900]!.withOpacity(0.6),
                //   overlayTextStyle: TextStyle(color: Colors.red[100]),
                //   timeLabelHeight: 32,
                // ),
                /** Customize axis labels */
                // timeLabel: (timestamp, visibleDataCount) => "📅",
                // priceLabel: (price) => "${price.round()} 💎",
                /** Customize overlay (tap and hold to see it)
                   ** Or return an empty object to disable overlay info. */
                // overlayInfo: (candle) => {
                //   "💎": "🤚    ",
                //   "Hi": "${candle.high?.toStringAsFixed(2)}",
                //   "Lo": "${candle.low?.toStringAsFixed(2)}",
                // },
                /** Callbacks */
                // onTap: (candle) => print("user tapped on "),
                // onCandleResize: (width) => print("each candle is  wide"),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  _computeTrendLines() {
    final ma7 = CandleData.computeMA(_data, 7);
    final ma30 = CandleData.computeMA(_data, 30);
    final ma90 = CandleData.computeMA(_data, 90);

    for (int i = 0; i < _data.length; i++) {
      _data[i].trends = [ma7[i], ma30[i], ma90[i]];
    }
  }

  _removeTrendLines() {
    for (final data in _data) {
      data.trends = [];
    }
  }
}
