// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:bitcoin_tracker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<String> cryptoValues = ['?', '?', '?'];

  void getBitcoinValue() async {
    CoinData coinData = CoinData();
    for (String crypto in cryptoList) {
      var data = await coinData.getPrice(crypto, selectedCurrency);
      setState(
        () {
          cryptoValues[cryptoList.indexOf(crypto)] = data;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getBitcoinValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCurrency(
                bitcoinValue: cryptoValues[0],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'BTC',
              ),
              CryptoCurrency(
                bitcoinValue: cryptoValues[1],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'ETH',
              ),
              CryptoCurrency(
                bitcoinValue: cryptoValues[2],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'LTC',
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              items: currenciesList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(growable: false),
              value: selectedCurrency,
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                  getBitcoinValue();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCurrency extends StatelessWidget {
  const CryptoCurrency({
    super.key,
    required this.bitcoinValue,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String bitcoinValue;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $bitcoinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
