import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localnotification/screen1.dart';
import 'package:localnotification/screen2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Local Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin1;

  @override
  void initState() {
    //here initializing both
    initializingSecondNotification();
    initializingSecondNotification();
    // TODO: implement initState
    super.initState();
  }

  void initializingFirstNotification(){
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationAndroidSetting = AndroidInitializationSettings(
        'mipmap/ic_launcher'); //this is for android
    var initializationIosSetting =
    IOSInitializationSettings(); //this is for ios
    var initializationSetting = new InitializationSettings(
        initializationAndroidSetting, initializationIosSetting);
    flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onSelectNotification: onSelect);
  }

  void initializingSecondNotification(){
    flutterLocalNotificationsPlugin1 = new FlutterLocalNotificationsPlugin();
    var initializationAndroidSetting = AndroidInitializationSettings(
        'mipmap/ic_launcher'); //this is for android
    var initializationIosSetting =
    IOSInitializationSettings(); //this is for ios
    var initializationSetting = new InitializationSettings(
        initializationAndroidSetting, initializationIosSetting);
    flutterLocalNotificationsPlugin1.initialize(initializationSetting,
        onSelectNotification: onSelect1);
  }
  Future onSelect(String payload) async {
    if(payload!=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Screen1(payload)));
    }
  }

  Future onSelect1(String payload) async {
    if(payload!=null){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Screen2(payload)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _showNotificationWithSound,
              child: Text("Click to fire notification"),
            ),
            RaisedButton(
              onPressed: _showNotificationonNextScreen,
              child: Text("Click to fire notification 1"),
            ),
          ],
        ),
      ),
    );
  }

  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: true, priority: Priority.Default);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, "title", "body", platformChannelSpecifics,
        payload: "This is content of notification"); //this is msg
  }

Future _showNotificationonNextScreen()async{
    var androidNotificationDetails=AndroidNotificationDetails("channelId1", "channelName1", "channelDescription1");
    var iosNotificationDetails=IOSNotificationDetails();
    var notificationDetails=NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin1.show(0, "title1", "body1", notificationDetails,payload: "this is next screen");
}
}
