import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<String> getPrice(String base, String quote) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$base/$quote?apikey=67204085-2FDF-45B5-8AF1-DDD8BAB3AF7F'),
    );
    var data = json.decode(response.body);
    String rate = data['rate'].toStringAsFixed(0);
    return rate;
  }
}
