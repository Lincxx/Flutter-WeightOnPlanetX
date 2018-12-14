import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  /** https://www.livescience.com/33356-weight-on-planets-mars-moon.html
   Mercury: 0.38
    Venus: 0.91
    Earth: 1.00
    Mars: 0.38
    Jupiter: 2.34
    Saturn: 1.06
    Uranus: 0.92
    Neptune: 1.19
    Pluto: 0.06 

    weight = mass * multiplier
 */

  final TextEditingController _weightController = new TextEditingController();

  int radioValue = 0;
  int weightValue = 0;

  double _finalResult = 0.0;
  String _formattedText = "";
  String _weight = "";

  //The radio button passes 'value' from the radion button as a parameter to this callback
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      switch (radioValue) {
        case 1:
          _finalResult = calculateWeight(_weightController.text, 0.06);
          break;
        case 2:
          _finalResult = calculateWeight(_weightController.text, 0.38);
          break;
        case 3:
          _finalResult = calculateWeight(_weightController.text, 0.91);
          break;
      }
      //print(radioValue);
    });
  }

  void handleRadioWeightChange(String measurement) {
    setState(() {
      switch (measurement) {
        case 'lbs':
          _formattedText =
              "Your weight on Pluto is: ${_finalResult.toStringAsFixed(1)}lbs";
          break;
        case 'kg':
          _formattedText =
              "Your weight on Pluto is: ${(_finalResult * 0.45359237).toStringAsFixed(1)}kgs";
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight On Planet X"),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
          alignment: Alignment.topCenter,
          child: ListView(
            padding: const EdgeInsets.all(2.5),
            children: <Widget>[
              Image.asset(
                'images/planet.png',
                height: 133.0,
                width: 200.0,
              ),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            labelText: 'Your Weight on Earth',
                            hintText: 'In Pounds',
                            icon: Icon(Icons.person_outline)),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      //Add three buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //radio buttons
                          Radio<int>(
                            activeColor: Colors.brown,
                            value: 1,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged,
                          ),
                          Text("Pluto",
                              style: TextStyle(color: Colors.white30)),
                          Radio<int>(
                            activeColor: Colors.redAccent,
                            value: 2,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged,
                          ),
                          Text("Mars", style: TextStyle(color: Colors.white30)),
                          Radio<int>(
                            activeColor: Colors.orangeAccent,
                            value: 3,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged,
                          ),
                          Text("Venus",
                              style: TextStyle(color: Colors.white30)),
                        ],
                      ),
                      //Result Text
                      Padding(
                        padding: EdgeInsets.all(15.6),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio<String>(
                            activeColor: Colors.amberAccent,
                            value: 'lbs',
                            groupValue: "weightValue",
                            onChanged: handleRadioWeightChange,
                          ),
                          Text("Weight in lbs"),
                          Radio<String>(
                            activeColor: Colors.amberAccent,
                            value: 'kg',
                            groupValue: "weightValue",
                            onChanged: handleRadioWeightChange,
                          ),
                          Text("Weight in kg:"),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.6),
                      ),
                      Text(
                          _weightController.text.isEmpty
                              ? "Please enter weight"
                              : _formattedText,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.4,
                              fontWeight: FontWeight.w500))
                    ],
                  ))
            ],
          )),
    );
  }

  double calculateWeight(String weight, double multiplier) {
    if (int.parse(weight).toString().isNotEmpty && int.parse(weight) > 0) {
      debugPrint(multiplier.toString());
      return int.parse(weight) * multiplier;
    } else {
      print("Wrong!");
      return int.parse("180") * 0.38;
    }
  }
}
