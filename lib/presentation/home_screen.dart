import 'package:cryptoforecast/data/models/icon_label.dart';
import 'package:cryptoforecast/presentation/journeys/more_screen.dart';
import 'package:cryptoforecast/presentation/journeys/news_screen.dart';
import 'package:cryptoforecast/presentation/journeys/trends_screen.dart';
import 'package:cryptoforecast/presentation/themes/colorz.dart';
import 'package:flutter/material.dart';

import 'journeys/explore_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List listOfWidgets = [
    const ExploreScreen(),
    const NewsScreen(),
    const TrendsScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorz.currenciesPageBackground,
      appBar: AppBar(
        backgroundColor: Colorz.currenciesPageBackground,
        title: const Text(
          "CRYPTO FORECAST",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notifications',
            onPressed: () {
              //Will Add Later
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Account',
            onPressed: () {
              //Will Add Later
            },
          ),
        ],
        elevation: 20.0,
      ),
      body: listOfWidgets[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => {
          setState(() => currentIndex = index),
        },
        items: iconLabels
            .map((iconLabel) =>
                item(iconLabel, iconLabels.indexOf(iconLabel) == currentIndex))
            .toList(),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colorz.currenciesNameColor,
        backgroundColor: Colorz.currenciesPageBackground,
      ),
    );
  }
}

BottomNavigationBarItem item(IconLabel iconLabel, bool selected) {
  return BottomNavigationBarItem(
      backgroundColor: Colorz.currenciesPageBackground,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator(selected),
          Icon(iconLabel.icon),
        ],
      ),
      label: iconLabel.label);
}

Widget indicator(bool selected) {
  Color color = selected ? Colorz.currencyIndicatorColor : Colors.transparent;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AnimatedContainer(
      height: 2.5, // selected? 2.5:0, let us keep it as fixed
      width: selected ? 70 : 0,
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(color: color, boxShadow: [
        BoxShadow(
          color: color,
          blurRadius: 2.25,
          spreadRadius: 0,
        ),
      ]),
    ),
  );
}

List<IconLabel> iconLabels = [
  IconLabel(Icons.explore_outlined, "Explore"),
  IconLabel(Icons.web_outlined, "News"),
  IconLabel(Icons.show_chart_outlined, "Trends"),
  IconLabel(Icons.more_horiz_outlined, "More"),
];
