import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageCutView extends StatefulWidget {
  final Map arguments;

  const ImageCutView({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    ui.Image _image = (arguments ?? {})['img'];
    String path = (arguments ?? {})['path'] ?? '';
    return ImageCutViewState(_image, path);
  }
}

class ImageCutViewState extends State<ImageCutView> {
  final ui.Image _image;
  final String path;

  ImageCutViewState(this._image, this.path);

  double sx = 0, sy = 0;

  double x= 0, y = 0;
  double radius = 200;

  Size cutSize;

  double imgActWidth = 100;
  double imgActHeight = 100;
  double minWid = 100;

  void initState() {
    super.initState();
  }

  void initRadius(BuildContext context) {
    if (cutSize != null) {
      return;
    }
    print('initRadius');
    this.cutSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
    );
    double conAsp = this.cutSize.aspectRatio;
    x = cutSize.width / 2;
    y = cutSize.height / 2;
    double imgAsp = _image.width / _image.height;
    print('conAsp = ' + conAsp.toString() + ', imgAsp = ' + imgAsp.toString());
    if (imgAsp <= conAsp) {
      imgActWidth = this.cutSize.height / _image.height * _image.width;
      imgActHeight = cutSize.height;
      minWid = min(imgActWidth, imgActHeight);
      this.radius = minWid / 2;
    } else {
      imgActWidth = cutSize.width;
      imgActHeight = this.cutSize.width / _image.width * _image.height;
      minWid = min(imgActWidth, imgActHeight);
      this.radius = minWid / 2;
    }
    print('imgActWidth = ' + imgActWidth.toString() + ', imgActHeight = ' + imgActHeight.toString());
  }

  edgeControl() {
    if (this.radius > this.minWid) {
      this.radius = this.minWid;
    }
    if (this.radius < this.minWid / 3) {
      this.radius = this.minWid / 3;
    }
    if (this.cutSize.width == imgActWidth) {
      if (this.x < 0 + this.radius / 2) {
        this.x = 0 + this.radius / 2;
      }
      if (this.x > imgActWidth - this.radius / 2) {
        this.x = imgActWidth - this.radius / 2;
      }
    } else {
      if (this.x < this.cutSize.width / 2 - imgActWidth / 2 + this.radius / 2) {
        this.x = this.cutSize.width / 2 - imgActWidth / 2 + this.radius / 2;
      }
      if (this.x > this.cutSize.width / 2 + imgActWidth / 2 - this.radius / 2) {
        this.x = this.cutSize.width / 2 + imgActWidth / 2 - this.radius / 2;
      }
    }
    if (this.cutSize.height == imgActHeight) {
      if (this.y < 0 + this.radius / 2) {
        this.y = 0 + this.radius / 2;
      }
      if (this.y > imgActHeight - this.radius / 2) {
        this.y = imgActHeight - this.radius / 2;
      }
    } else {
      if (this.y < this.cutSize.height / 2 - imgActHeight / 2 + this.radius / 2) {
        this.y = this.cutSize.height / 2 - imgActHeight / 2 + this.radius / 2;
      }
      if (this.y > this.cutSize.height / 2 + imgActHeight / 2 - this.radius / 2) {
        this.y = this.cutSize.height / 2 + imgActHeight / 2 - this.radius / 2;
      }
    }
  }

  saveImage() async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    Rect trans = Rect.fromCenter(center: Offset(x, y), width: radius, height: radius);
    // because i make img keep asp ratio, so the following value rateX and rateY is equal, img without any scale
    double rateX = _image.width / imgActWidth;
    double rateY = _image.height / imgActHeight;
    Rect src = Rect.fromLTWH(0 , 0, _image.width * 1.0, _image.height * 1.0);
    if (imgActHeight == this.cutSize.height) {
      double xPadding = (this.cutSize.width - imgActWidth) / 2;
      src = Rect.fromLTWH((x - radius / 2 - xPadding) * rateX , (y - radius / 2) * rateY, trans.width * rateX, trans.width * rateX);
    } else {
      double yPadding = (this.cutSize.height - imgActHeight) / 2;
      src = Rect.fromLTWH((x - radius / 2) * rateX , (y - radius / 2 - yPadding) * rateY, trans.width * rateY, trans.width * rateY);
    }
    print('rateX = ' + rateX.toString() + ', rateY = ' + rateY.toString());
    print('_image.width = ' + _image.width.toString() + ', _image.height = ' + _image.height.toString());
    print(trans);
    print(src);
    Rect dest = Rect.fromLTWH(0, 0, 400, 400);
    canvas.drawImageRect(_image, src, dest, new Paint());
    ui.Image img = await recorder.endRecording().toImage(400, 400);
    Navigator.pop(context, img);
  }

  @override
  Widget build(BuildContext context) {
    initRadius(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('图片裁剪'),
        actions: [
          Tooltip(
            message: '保存',
            child: InkWell(
              onTap: () {
                this.saveImage();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.photo_size_select_large),
              ),
            ),
          )
        ],
      ),
      body: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onDoubleTap: () async {
                  this.saveImage();
                },
                onScaleStart: (ScaleStartDetails details) {
                  this.sx = details.focalPoint.dx;
                  this.sy = details.focalPoint.dy;
                },
                onScaleEnd: (ScaleEndDetails details) {
                 this.edgeControl();
                },
                onScaleUpdate: (ScaleUpdateDetails details) {
                  var dx = details.focalPoint.dx - this.sx;
                  var dy = details.focalPoint.dy - this.sy;
                  if (details.scale > 1) {
                    this.radius *= 1.01;
                  } else if (details.scale < 1) {
                    this.radius *= 0.99;
                  }
                  print('this.radius---' + this.radius.toString());
                  this.x += dx;
                  this.y += dy;

                  this.edgeControl();

                  setState(() {});
                  this.sx = details.focalPoint.dx;
                  this.sy = details.focalPoint.dy;
                },
                child: Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).padding.top + kToolbarHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(File(path)),
                      CustomPaint(
                        painter: ImageCutPainter(x, y, radius),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageCutPainter extends CustomPainter {
  Paint _paint;

  final double dx;
  final double dy;
  final double radius;

  ImageCutPainter(this.dx, this.dy, this.radius) {
    _paint = Paint();
  }

  // @override
  // bool hitTest(ui.Offset position) {
  //   print('hitTest' + position.toString());
  //   return true;
  // }

  @override
  paint(Canvas canvas, Size size) {
    print('size---' + size.toString());
    _paint.color = Colors.black;
    _paint.style = PaintingStyle.fill;
    _paint.color = Color(0x7F000000);
    Rect trans = Rect.fromCenter(center: Offset(dx, dy), width: radius, height: radius);
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.addOval(trans);
    canvas.drawPath(path, _paint);

    TextPainter textPainter = TextPainter(text: TextSpan(text: '双指缩放 双击保存'), textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, trans.center.translate(-textPainter.width / 2, -textPainter.height / 2));
  }

  // covariant make child class can reset params type, but it should be the parent's subclass
  @override
  bool shouldRepaint(covariant ImageCutPainter imageCut) {
    return imageCut.dx != dx || imageCut.dy != dy || imageCut.radius != radius;
  }
}
