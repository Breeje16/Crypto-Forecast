import 'dart:async';

import 'package:cryptoforecast/di/get_it.dart';
import 'package:cryptoforecast/domain/entities/coins_entity.dart';
import 'package:cryptoforecast/presentation/blocs/coin_list/coin_list_bloc.dart';
import 'package:cryptoforecast/presentation/journeys/chart_screen.dart';
import 'package:cryptoforecast/presentation/themes/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late CoinListBloc coinListBloc;

  @override
  void initState() {
    coinListBloc = getItInstance<CoinListBloc>();
    coinListBloc.add(const CoinsLoadEvent());
    Timer.periodic(const Duration(seconds: 20),
        (timer) => coinListBloc.add(const CoinsLoadEvent()));
    super.initState();
  }

  @override
  void dispose() {
    coinListBloc.close();
    super.dispose();
  }

  Widget lable(String percent, bool negative) {
    return Padding(
      padding: const EdgeInsets.only(right: 32.0),
      child: Container(
        child: Text('${negative ? '' : '+'}$percent%',
            style: const TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        margin: const EdgeInsets.only(left: 8.0),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: negative ? Colors.red : Colorz.currencyPositiveGreen,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Card makeCard(CoinsEntity coins) => Card(
        elevation: 16.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration:
              const BoxDecoration(color: Colorz.currenciesPageBackground),
          // const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTile(coins),
        ),
      );

  ListTile makeListTile(CoinsEntity coins) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          height: 55,
          width: 55,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              coins.imageUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
          // Icon(coin.icon, color: Colors.white, size: 34),
          decoration: BoxDecoration(
              border: Border.all(
                color: coins.changePercentage < 0
                    ? Colors.red
                    : Colorz.currencyPositiveGreen,
                width: 2,
              ),
              color: Colorz.currenciesPageBackground,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: coins.changePercentage < 0
                      ? Colors.red
                      : Colorz.currencyPositiveGreen,
                  blurRadius: 1,
                  // spreadRadius: 0.5,
                )
              ]),
        ),

        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            coins.name + " (" + coins.symbol.toUpperCase() + ")",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colorz.compexDrawerCanvasColor,
            ),
          ),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$" + coins.price.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            lable(coins.changePercentage.toStringAsFixed(2).toString(),
                coins.changePercentage < 0),
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_right,
            color: Colors.white, size: 30.0),
        onTap: () {
          if (coins.symbol != 'usdt') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChartScreen(
                        coinid: coins.id,
                      )),
            );
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => coinListBloc,
      child: Container(
        decoration: const BoxDecoration(color: Colorz.currenciesPageBackground),
        child: BlocBuilder<CoinListBloc, CoinListState>(
          builder: (context, state) {
            if (state is CoinListLoaded) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.coins.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(state.coins[index]);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
