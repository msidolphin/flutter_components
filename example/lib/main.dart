import 'package:flutter/material.dart';
import 'package:flutter_components/widgets.dart';
import './view/Sample.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToastInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        ).copyWith(
          primaryColor: Color(0xff409bff)
        ),
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialWithModalsPageRoute(
                  builder: (_) => MyHomePage(title: 'Flutter Demo Home Page'),
                  settings: settings);
          }
          return null;
        },
      ),
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
    return Material(
      child: Scaffold(
        body: Sample() // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
