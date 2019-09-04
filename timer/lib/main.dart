import 'package:flutter/material.dart';
import 'dart:async';
const PrimaryColor = const Color(0xffff1b2d);

void main() => runApp(TimerApp());

class TimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerAppState();
  }
}

class TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  int defaultTime = 0;
  bool isActive = false;
  bool stopTime = true;


  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
    elif (stopTime){
    	setState(() {
    		secondsPassed=0;
    		defaultTime=0;
    	});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed %(60*60) ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      title: 'Welcome to Flutter',
      theme:ThemeData(
      primaryColor: PrimaryColor,
      ),
      home: Scaffold(
      	backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('計時器'),
          flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xff9d4eff),
                  const Color(0xffeb004a),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 0.8],
                tileMode: TileMode.clamp),
          ),
        ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      label: '時', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: '分', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: '秒', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  child: Text(isActive ? '暫停' : '開始'),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 0),
                child: RaisedButton(
                  child: Text('重設'),
                  onPressed: () {
                    setState(() {
                      isActive = false;
                      stopTime = stopTime;
                      secondsPassed=defaultTime;
                    });
                  },
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      padding: EdgeInsets.all(22),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(30),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.red,
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white,

            ),
          )
        ],
      ),
    );
  }
}