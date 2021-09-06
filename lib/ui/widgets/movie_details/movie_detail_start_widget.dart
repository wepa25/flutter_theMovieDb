import 'package:flutter/material.dart';
import 'package:the_movie/ui/widgets/movie_list/movies_images.dart';

class MovieDetailStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          height: 162,
          width: double.infinity,
          image: MoviesImages.mortalDetail,
          colorBlendMode: BlendMode.hardLight,
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 10,
          top: 20,
          bottom: 30,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Color.fromRGBO(10, 7, 8, 1.0),blurRadius: 15,offset: Offset(-18,15),spreadRadius: 30.0)],
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Image(
              image: MoviesImages.mortal,
            ),
          ),
        ),
      ],
    );
  }
}
