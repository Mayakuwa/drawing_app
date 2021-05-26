import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _PaintData {
  //パス
  Path path;

  _PaintData({
    this.path,
  }) : super();

}

  /*
   * ペイントの履歴を管理
   * ジェクチャーを受け取り線のデータを管理
   * undoやredo、clear機能
   */
class PaintHistory {
  //key/value形式のデータをmapするときは、MapEntryを使うと便利

  //ペイントの履歴リスト
  List<MapEntry<_PaintData, Paint>> _paintList = [];

  //ペイントundoリスト
  List<MapEntry<_PaintData, Paint>> _undoneList = [];

  //背景ペイント
  Paint _backgroundPaint = Paint();

  //ドラッグ中フラグ
  bool _inDrag = false;

  //カレントペイントイベント
  Paint currentPaint;

  // undo できるかどうか(実行した操作を取り消せるかどうか) ロールバック
  bool canUndo() => _paintList.length > 0;

  // redoできるかどうか(一度やったことができるかどうか)　ロールフォーワード
  bool canRedo() => _undoneList.length > 0;

  /*
   * undo
   */
  void undo() {
    if(!_inDrag && canUndo()) {
      _undoneList.add(_paintList.removeLast());
    }
  }

  /*
   * redo
   */
  void redo() {
    if(!_inDrag && canRedo()) {
      _paintList.add(_undoneList.removeLast());
    }
  }

  /*
   * clear
   */
  void clear() {
    if(!_inDrag) {
      _paintList.clear();
      _undoneList.clear();
    }
  }

  /*
   * 背景色セッター
   */
  set backgroudColor(color) => _backgroundPaint.color = color;

  /*
   * 線ペイント開始
   */
  void addPaint(Offset startPoint) {
    //ドラッグを開始
    if(!_inDrag) {
      _inDrag = true;
      Path path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _PaintData data = _PaintData(path: path);
      _paintList.add(MapEntry<_PaintData, Paint>(data, currentPaint));
    }
  }

  /*
   * 線ペイント更新
   */
  void updatePaint(Offset nextPoint) {
    if(_inDrag) {
      _PaintData data = _paintList.last.key;
      Path path = data.path;
      //パスを更新
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  /*
   * 線ペイント終了
   */
  void endPaint() {
    //フラグをfalseにする
    _inDrag = false;
  }

  /*
   * 描写
   */
  void draw(Canvas canvas, Size size) {
    //背景
    canvas.drawRect(
        Rect.fromLTWH(
            0.0,
            0.0,
            size.width,
            size.height
        ),
        _backgroundPaint
    );

    /*
   * 線描写
   */
    for (MapEntry<_PaintData, Paint> data in _paintList) {
      if(data.key.path != null) {
        canvas.drawPath(data.key.path, data.value);
      }
    }
  }
}