import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'coin_data.dart';

import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency;

  String btcData;
  String ethData;
  String ltcData;

  Widget androidDropdown() {
    List <DropdownMenuItem<String>> theList = [];
    for (String items in currenciesList) {
      var listD = DropdownMenuItem(child: Text(items, style: TextStyle(
        color: Colors.white,

      ),),
        //backgroundColor: Color(0xff5773FE),
        value: items,);
      theList.add(listD);
    }


    return DropdownButton <String>(
        iconEnabledColor: Colors.black,
        dropdownColor: kPurple,
        focusColor: kPurple,
        value: selectedCurrency,
        items: theList,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            print(selectedCurrency);
            getText();
            //getText(selectedCurrency);
            //textRate = await getText(selectedCurrency);
          });
          //return textRate;
        });
  }

  Widget cupertinoScroll() {
    List <Text> theList = [];

    for (String items in currenciesList) {
      var listD = Text(items);
      theList.add(listD);
      CupertinoPicker(itemExtent: 30.0, onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        getText();
        // textRate = await getText(selectedCurrency);
      }, children: theList);

      //return textRate;
    }
  }


  void getText() async {
    CoinData coinData = CoinData();
    String theCurrency = selectedCurrency;
    try {
      for (String crypto in cryptoList) {
        if (crypto == 'BTC') {
          var it = await coinData.getCoinData(
              'https://rest.coinapi.io/v1/exchangerate/$crypto/$theCurrency?apikey=$apiKey');
          setState(() {
            btcData = it.toString();
          },
          );
        }
        if (crypto == 'ETH') {
          var it = await coinData.getCoinData(
              'https://rest.coinapi.io/v1/exchangerate/$crypto/$theCurrency?apikey=$apiKey');
          setState(() {
            ethData = it.toString();
          },
          );}
        if (crypto == 'LTC') {
          var it = await coinData.getCoinData(
              'https://rest.coinapi.io/v1/exchangerate/$crypto/$theCurrency?apikey=$apiKey');
          setState(() {
            ltcData = it.toString();
          },
          );
        }
      }
    }
    catch (e) {
      print(e);
    }
  }

//     @override
//   void initState() {
//   super.initState();
// getText();
//   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: Text('Coin Ticker', style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //BTC Card
          //SpaceEv
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
            child: Card(
              color: kPurple,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  //'helo',
                  '1 BIT = $btcData',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          //SizedBox(height: 0.5,),
          //ETH Card
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
            child: Card(
              color: kPurple,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  //'helo',
                  '1 BIT = $ethData',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          //LTC Card
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: kPurple,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  //'helo',
                  '1 BIT = $ltcData',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 300.0),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: kBlue,
            child: Platform.isIOS ? cupertinoScroll() : androidDropdown(),


          )

        ],
      ),
    );
  }
}
