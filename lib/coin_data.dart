import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
  'DOGE',
];

class CoinData {
  String selectedCurrency;
  String crypto;
  CoinData(this.crypto, this.selectedCurrency);

  Future getCoinData() async {
    var url = Uri.https(
        'rest.coinapi.io', '/v1/exchangerate/$crypto/$selectedCurrency', {
      'apikey': '#Put your api Key Here',
    });
    var response = await http.get(url);
    var data = response.body;
    if (response.statusCode == 200) {
      var decodedData = convert.jsonDecode(data);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
    }
  }
}
