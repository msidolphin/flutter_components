
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/Button.dart';

class DrawerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerViewState();
  }


}

class DrawerViewState extends State<DrawerView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer'),

      ),
      endDrawer: Container(
        width: 300,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Inner'),
          ),
          body: Material(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (_) {
                      return Button('打开抽屉', onPressed: () {
                        Scaffold.of(_).openEndDrawer();
                      },);
                    },
                  )
              ),
            ),
          ),
          endDrawer: Scaffold(
            appBar: AppBar(
              title: Text('Inner'),
            ),
            body: Material(
              child: Column(
                children: [
                  Text('drawer')
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (_) {
              return Button('打开抽屉', onPressed: () {
                Scaffold.of(_).openEndDrawer();
              },);
            },
          )
        ),
      ),
    );
  }


}