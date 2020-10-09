import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movies_challenge/model/movie_details.model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailsView extends StatefulWidget {
  final MovieDetailsModel details;

  DetailsView({@required this.details});

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  PanelController _panelController = new PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
          controller: _panelController,
          defaultPanelState: PanelState.OPEN,
          color: Colors.transparent,
          boxShadow: [],
          panel: CustomPaint(
            painter: CurvePainter(),
            child: Center(
              child: Column(
                children: [
                  Text(widget.details.title),
                  Text(widget.details.overview),
                  Text(widget.details.popularity.toString()),
                ],
              ),
            ),
          ),
          body: GestureDetector(
            child: Image.network(
              widget.details.posterUrl,
              errorBuilder:
                  (BuildContext context, Object object, StackTrace stacktrace) {
                return Image.asset(
                  "lib/assets/images/movie_placeholder.png",
                  fit: BoxFit.fill,
                );
              },
              fit: BoxFit.fill,
            ),
            onTap: () {
              if (_panelController.isPanelOpen) {
                _panelController.close();
              } else {
                _panelController.open();
              }
            },
          )),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.2,
        size.width * 1.0, size.height * 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
