import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/model/movie_details.model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'components/custom_image.component.dart';
import 'components/carousel_item.component.dart';
import 'components/item_details.component.dart';

class DetailsView extends StatefulWidget {
  final MovieDetailsModel details;

  DetailsView({@required this.details});

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView>
    with SingleTickerProviderStateMixin {
  PanelController _panelController = new PanelController();

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _carouselItem = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SlidingUpPanel(
          controller: _panelController,
          defaultPanelState: PanelState.OPEN,
          color: Colors.transparent,
          boxShadow: [],
          panel: CustomPaint(
            painter: CurvePainter(),
            child: Container(
                child: ItemDetail(_panelController, _animationController,
                    item: widget.details)),
          ),
          body: GestureDetector(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(bottom: 25),
              child: CustomImage(
                  imageUrl: widget.details.posterUrl,
                  isValidImage: _carouselItem),
            ),
            onTap: () {
              if (_panelController.isPanelOpen) {
                _panelController.close();
                _animationController.forward();
              } else {
                _panelController.open();
                _animationController.reset();
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
    paint.color = Color.fromRGBO(248, 248, 255, 1);
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
