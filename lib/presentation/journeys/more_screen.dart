import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Best Platforms to Buy Cryptocurrencies in India:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )),
        Row(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/coindcx.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/wazirx.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/coinswitch.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
        const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "About CryptoForecast",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )),
        const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "This Analysis has been Done only for Educational Purposes. Investment should be Done on your Own Risk. We at CryptoForecast helps you with Data Analysis but Be Responsible and Invest only After understanding in depth about Cryptocurrencies!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
