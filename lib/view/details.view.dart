import 'package:flutter/material.dart';
import 'package:movies_challenge/model/movie_details.model.dart';

class DetailsView extends StatelessWidget {
  final MovieDetailsModel details;

  DetailsView({@required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
