import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String i in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          i,
          style: TextStyle(color: Colors.black),
        ),
        value: i,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData();
            // print(selectedCurrency);
          });
        });
  }
  // }

  // List getCurrencyLoop() {
  //   List dropDownItems =[];
  //   for (int i = 0; i < currenciesList.length; i++) {
  //     String currency = currenciesList[i];
  //    var newItem = DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropDownItems.add(newItem);
  //   }
  //
  //   return dropDownItems;
  //

  // List getCurrencyLoop() {
  //   // List<DropdownMenuItem<String>> dropDownItems = [];
  //   //
  //   // for (String i in currenciesList) {
  //   //   var newItem = DropdownMenuItem(
  //   //     child: Text(i),
  //   //     value: i,
  //   //   );
  //   //   dropDownItems.add(newItem);
  //   // }
  //   //
  //   // return dropDownItems;
  // }
  // Para cada item na currenciesList, quero substituir o Text e o value do DropDownMenuItem por este item
  // Depois quero adicionar esse DropDownMenuItem criado em uma lista de dropDownItems, para isso vou v=identificá-lo como newItem
  // E depois que meu loop acabar, quero mostrar essa lista de DropDownMenus ou newItems

  CupertinoPicker iosPicker() {
    List<Text> textCurrencyName = [];

    for (String i in currenciesList) {
      textCurrencyName.add(Text(
        i,
        style: TextStyle(color: Colors.black),
      ));
    }

    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: textCurrencyName,
    );
  }

  // List<Text> getPickerItems() {
  //   List<Text> textCurrencyName = [];
  //
  //   for (String i in currenciesList) {
  //     textCurrencyName.add(Text(
  //       i,
  //       style: TextStyle(color: Colors.white),
  //     ));
  //   }
  //   return textCurrencyName;
  // }

  // Método para ver equal picker chamar dependendo do aparelho .Importar pack io, substiuído por ternário
  // Widget getPicker(){
  //   if(Platform.isIOS) {
  //     return iosPicker();
  //   } else if (Platform.isAndroid) {
  //     return androidDropDownButton();
  //   }
  // }
// TODO 1.1: Atribuindo os dados a uma variavel
  Map coinValue = {};
  bool isWaiting = false;

  Future getData() async {
    isWaiting = true;
    var fetchValue = await CoinData().getCoinData(selectedCurrency);
    isWaiting = false;
    setState(() {
      coinValue = fetchValue;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '🤑 Coin Ticker',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
              cryptoName: 'BTC',
              coinValue: isWaiting ? '?' : coinValue['BTC'],
              selectedCurrency: selectedCurrency),
          CryptoCard(
              cryptoName: 'ETH',
              coinValue: isWaiting ? '?' : coinValue['ETH'],
              selectedCurrency: selectedCurrency),
          CryptoCard(
              cryptoName: 'LTC',
              coinValue: isWaiting ? '?' : coinValue['LTC'],
              selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.amber,
            // ANDROID
            // child: DropdownButton<String>(
            //     value: selectedCurrency,
            //     items: getCurrencyLoop(),
            //     onChanged: (value) {
            //       setState(() {
            //         selectedCurrency = value;
            //       });
            //     }),
            // child: CupertinoPicker(
            //   itemExtent: 30,
            //   onSelectedItemChanged: (selectedIndex) {
            //     print(selectedIndex);
            //   },
            //   children: getPickerItems(),
            // ),
            child: Platform.isIOS
                ? iosPicker()
                : androidDropDownButton(), // ios é exceção
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.cryptoName,
    @required this.coinValue,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String cryptoName;
  final String coinValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.amber,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoName = $coinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
