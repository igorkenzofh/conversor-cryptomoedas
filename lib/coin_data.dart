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

//TODO 1: Pegando os dados da internet
class CoinData {
  Future getCoinData(String chooseCurrency) async {
    Map cryptoPrices = {};
    for (String cryptoCurrency in cryptoList) {
      var url =
          'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$chooseCurrency?apiKey=5786ACCC-C395-4BBE-98A4-F915D0D8D0BE';
      var response = await http.get(url);

      if (response.statusCode == 200) {
        String data = response.body;
        // print(jsonDecode(data)['rate']);
        double lastPrice = jsonDecode(data)['rate'];
        cryptoPrices[cryptoCurrency] = lastPrice.toStringAsFixed(1);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
