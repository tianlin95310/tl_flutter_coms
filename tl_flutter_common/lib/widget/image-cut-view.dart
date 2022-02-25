import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageCutView extends StatefulWidget {
  final Map arguments;

  const ImageCutView({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    ui.Image _image = (arguments ?? {})['img'];
    return ImageCutViewState(_image);
  }
}

class ImageCutViewState extends State<ImageCutView> {
  final ui.Image _image;

  ImageCutViewState(this._image);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片裁剪'),
      ),
      body: Scaffold(
        body: Column(
          children: [
            // Image(image: FileImage(File(_image.path))),
            Container(
              width: double.infinity,
              height: 500,
              child: CustomPaint(
                painter: ImageCut(_image),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageCut extends CustomPainter {
  final ui.Image _image;
  Paint _paint;

  ImageCut(this._image){
    _paint = Paint();
  }

  @override
  paint(Canvas canvas, Size size) {
    print('size---' + size.toString());
    _paint.color = Colors.black;
    Rect src = Rect.fromLTWH(0, 0, _image.width * 1.0, _image.height * 1.0);
    Rect dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(_image, src, dst, _paint);
    canvas.save();

    _paint.style = PaintingStyle.fill;
    Rect trans = Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 100, height: 100);
    _paint.color = Color(0x1FFF0000);
    Path path = Path();
    path.fillType = PathFillType.nonZero;
    path.addRect(dst);
    path.addOval(trans);
    canvas.drawPath(path, _paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
