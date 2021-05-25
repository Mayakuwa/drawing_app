import 'package:drawing_app/define/Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintScreen extends StatefulWidget {
  @override
  _PaintScreenState createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お絵描き'),
      ),
      body: Container(
        color: Common.primaryColor.shade50
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'undo',
            onPressed: () {

            },
            child: Text('Undo'),
          ),
          SizedBox(
            height: 20.0,
          ),
          FloatingActionButton(
            heroTag: 'redo',
            onPressed: () {

            },
            child: Text('Redo'),
          ),
          SizedBox(
            height: 20.0,
          ),
          FloatingActionButton(
            heroTag: 'clear',
            onPressed: () {

            },
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }
}
