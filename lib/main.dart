import 'package:blood_donation_system/screens/home/guest_home_screen.dart';
import 'package:blood_donation_system/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, _) => MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ApplicationState> (
          builder: (context, appState, _) {
            if(appState.isUserLogged) {
              return HomeScreen();
            }else {
              return GuestHomeScreen();
            }
          },
      ),
    );
  }
}
