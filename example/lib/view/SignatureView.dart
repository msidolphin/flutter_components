import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/signature/Signature.dart';
import 'package:flutter_components/utils/Ui.dart';

class SignatureView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SignatureViewState();
  }

}

class _SignatureViewState extends State<SignatureView> {

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          //SIGNATURE CANVAS
          Signature(
            controller: _controller,
            backgroundColor: Colors.white,
          ),
          //OK AND CLEAR BUTTONS
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //SHOW EXPORTED IMAGE IN NEW ROUTE
                IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.blue,
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final Uint8List data = await _controller.toPngBytes();
                      Ui.showCupertinoBottomSheet(context, builder: (ctx, sc) {
                        return Material(
                          color: Colors.white,
                          child: Container(
                            height: 340,
                            child: Center(
                              child: Image.memory(data, fit: BoxFit.contain,),
                            ),
                          ),
                        );
                      }, expand: false);
                    }
                  },
                ),
                //CLEAR CANVAS
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}