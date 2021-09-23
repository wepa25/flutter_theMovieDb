import 'package:flutter/material.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/library/inherited/provider.dart';
import 'package:the_movie/ui/widgets/movie_details/movie_detail_model.dart';
import 'package:the_movie/ui/widgets/movie_list/movies_images.dart';

class MovieDetailStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 500 / 281,
      child: Stack(
        children: [
          backdropPath == null ? SizedBox.shrink()  :
          Image.network(ApiClient.imageUrl(backdropPath),
            // height: 162,
            // width: double.infinity,
            colorBlendMode: BlendMode.hardLight,
            fit: BoxFit.fill,
          ),
          Positioned(
            left: 20,
            top: 20,
            bottom: 20,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Color.fromRGBO(10, 7, 8, 1.0),blurRadius: 5,offset: Offset(1,1),spreadRadius: 1.0)],
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: posterPath == null ? SizedBox.shrink() :
              Image.network(ApiClient.imageUrl(posterPath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
