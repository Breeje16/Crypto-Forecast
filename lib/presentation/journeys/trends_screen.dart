import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({Key? key}) : super(key: key);

  @override
  _TrendsScreenState createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  late List<FearIndexData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              "Fear Index",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )),
        SfCircularChart(
            title: ChartTitle(
              text: "Bitcoin",
              textStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                backgroundColor: Colors.white),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<FearIndexData, String>(
                  dataSource: _chartData,
                  xValueMapper: (FearIndexData data, _) => data.name,
                  yValueMapper: (FearIndexData data, _) => data.value,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ]),
        SfCircularChart(
            title: ChartTitle(
              text: "Ethereum",
              textStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                backgroundColor: Colors.white),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<FearIndexData, String>(
                  dataSource: ethData,
                  xValueMapper: (FearIndexData data, _) => data.name,
                  yValueMapper: (FearIndexData data, _) => data.value,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ]),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Twitter Sentiments",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )),
        SfCircularChart(
            title: ChartTitle(
              text: "Bitcoin Twitter Sentiments",
              textStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                backgroundColor: Colors.white),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              DoughnutSeries<FearIndexData, String>(
                  dataSource: bitcoinTwitter,
                  xValueMapper: (FearIndexData data, _) => data.name,
                  yValueMapper: (FearIndexData data, _) => data.value,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ]),
        SfCircularChart(
            title: ChartTitle(
              text: "Ethereum Twitter Sentiments",
              textStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                backgroundColor: Colors.white),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              DoughnutSeries<FearIndexData, String>(
                  dataSource: ethTwitter,
                  xValueMapper: (FearIndexData data, _) => data.name,
                  yValueMapper: (FearIndexData data, _) => data.value,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ]),
      ]),
    );
  }

  final List<FearIndexData> ethData = [
    FearIndexData("Positive", 60),
    FearIndexData("Neutral", 20),
    FearIndexData("Negative", 20),
  ];

  final List<FearIndexData> bitcoinTwitter = [
    FearIndexData("Positive", 30),
    FearIndexData("Neutral", 5),
    FearIndexData("Negative", 65),
  ];

  final List<FearIndexData> ethTwitter = [
    FearIndexData("Positive", 65),
    FearIndexData("Neutral", 5),
    FearIndexData("Negative", 30),
  ];

  List<FearIndexData> getChartData() {
    final List<FearIndexData> chartData = [
      FearIndexData("Positive", 35),
      FearIndexData("Neutral", 10),
      FearIndexData("Negative", 55),
    ];

    return chartData;
  }
}

class FearIndexData {
  final String name;
  final int value;
  FearIndexData(this.name, this.value);
}
