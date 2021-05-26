import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'PaintHistory.dart';

class Painter extends StatefulWidget {

  //ペイントコントローラー
  final PaintController painterController;

  Painter({
   @required this.painterController
  }) : super(key: ValueKey<PaintController>(painterController)) {
    assert(this.painterController != null);
  }

  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //イベント監視
      child: GestureDetector(

        //カスタムペイント
        child: CustomPaint(
          willChange: true,
          painter: _CustomPainter(
            widget.painterController._paintHistory,
            repaint: widget.painterController
          ),
        ),
        onPanStart: _onPaintStart,
        onPanUpdate: _onPaintUpdate,
        onPanEnd: _onPaintEnd,
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  /*
   * 線ペイントの開始
   */
  void _onPaintStart(DragStartDetails start) {
    widget.painterController._paintHistory.addPaint(_getGlobalToLocalPosition(start.globalPosition));
  }

  /*
   * 線ペイントの更新
   */
  void _onPaintUpdate(DragUpdateDetails update) {
    widget.painterController._paintHistory.updatePaint(_getGlobalToLocalPosition(update.globalPosition));
    widget.painterController._notifyListeners();
  }

  /*
   * 線ペイントの終了
   */
  void _onPaintEnd(DragEndDetails end) {
    widget.painterController._paintHistory.endPaint();
    widget.painterController._notifyListeners();
  }

  /*
   * ローカルのオフセットへ変換
   */
  Offset _getGlobalToLocalPosition(Offset global) {
    return (context.findRenderObject() as RenderBox).globalToLocal(global);
  }
}

  /*
   * _CustomPainterクラスは、CustomPainterを継承しており、
   * 描写のカスタマイズをするためのもの。
   */

  class _CustomPainter extends CustomPainter {

    final PaintHistory _paintHistory;
    _CustomPainter(
        this._paintHistory,
        {
          Listenable repaint
        }) : super(repaint: repaint);

    @override
    void paint(Canvas canvas, Size size) {
      _paintHistory.draw(canvas, size);
    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  }

  /*
   * ペイントの履歴(PaintHistory)を保持
   * 線の太さなどの設定データを保持（または変更できる）
   * undoやredo、clearの制御の受け取り口を持っていて実行をPaintHistoryへ指示する
   */
class PaintController extends ChangeNotifier {

  // ペイント履歴
  PaintHistory _paintHistory = PaintHistory();
  //　線の色
  Color _drawColor = Color.fromARGB(225, 0, 0, 0);
  //　線幅
  double _thickness = 5.0;
  // 背景色
  Color _backgroundColor = Color.fromARGB(255, 255, 255, 255);

  /*
   * コンストラクタ
   */
  PaintController(): super() {
    //ペイント設定
    Paint paint = Paint();
    paint.color = _drawColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = _thickness;
    _paintHistory.currentPaint = paint;
    _paintHistory.backgroudColor = _backgroundColor;
  }

  /*
   * undoを実行
   */
  void undo() {
    _paintHistory.undo();
    ChangeNotifier();
  }

  /*
   * redoを実行
   */
  void redo() {
    _paintHistory.redo();
    ChangeNotifier();
  }

  /*
   * undo可能か
   */
  bool get canUndo => _paintHistory.canUndo();

  /*
   * redo可能か
   */
  bool get canRedo => _paintHistory.canRedo();

  /*
   * リスナー実行
   */
  void _notifyListeners() {
    notifyListeners();
  }

  /*
   * リスナー実行
   */
  void clear() {
    _paintHistory.clear();
    notifyListeners();
  }
}