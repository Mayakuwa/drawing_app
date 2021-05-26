import 'package:drawing_app/Painter.dart';
import 'package:drawing_app/define/Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintScreen extends StatefulWidget {
  @override
  _PaintScreenState createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {

  //コントローラー
  PaintController _controller = PaintController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お絵描き'),
        centerTitle: true,
      ),
      body: Container(
        child: Painter(
          painterController: _controller,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'undo',
            onPressed: () {
              if(_controller.canUndo) {
                _controller.undo();
              }
            },
            child: Text('Undo'),
          ),
          SizedBox(
            height: 20.0,
          ),
          FloatingActionButton(
            heroTag: 'redo',
            onPressed: () {
              if(_controller.canRedo) {
                _controller.redo();
              }
            },
            child: Text('Redo'),
          ),
          SizedBox(
            height: 20.0,
          ),
          FloatingActionButton(
            heroTag: 'clear',
            onPressed: () => _controller.clear(),
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }
}
