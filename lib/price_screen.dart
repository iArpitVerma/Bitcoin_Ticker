import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  String btcValue = '?';
  String ethValue = '?';
  String dogeValue = '?';

  void getData() async {
    btcValue = '?';
    ethValue = '?';
    dogeValue = '?';
    String value = '?';

    try {
      for (int i = 0; i <= 2; i++) {
        double data =
            await CoinData(cryptoList[i], selectedCurrency).getCoinData();
        setState(() {
          value = data.toStringAsFixed(2);
        });
        if (i == 0)
          btcValue = value;
        else if (i == 1)
          ethValue = value;
        else
          dogeValue = value;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var newItem = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropDownList.add(newItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> widgetList = [];
    for (int i = 0; i < currenciesList.length; i++) {
      widgetList.add(Text(currenciesList[i]));
    }

    return CupertinoPicker(
      children: widgetList,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                Value: btcValue,
                selectedCurrency: selectedCurrency,
                cryptoCurrency: cryptoList[0],
              ),
              CryptoCard(
                Value: ethValue,
                selectedCurrency: selectedCurrency,
                cryptoCurrency: cryptoList[1],
              ),
              CryptoCard(
                Value: dogeValue,
                selectedCurrency: selectedCurrency,
                cryptoCurrency: cryptoList[2],
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.Value,
    @required this.selectedCurrency,
    @required this.cryptoCurrency,
  }) : super(key: key);

  final String Value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency =  $Value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
