import 'package:flutter/material.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/library/inherited/provider.dart';
import 'package:the_movie/ui/widgets/movie_list/app_movie_model.dart';

class MovieListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MoviesListModel>(context);
    if (model == null) return SizedBox.shrink();
    return Stack(
      children: [
        model.movies.isEmpty ? Center(child: CircularProgressIndicator(strokeWidth: 2,),) :
        ListView.builder(
            physics: BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(top: 50),
            itemExtent: 163,
            itemCount: model.movies.length,
            itemBuilder: (BuildContext context, int index) {
              model.showedMoviesIndex(index);
              final movie = model.movies[index];
              final posterPath = movie.posterPath;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.black),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          movie.posterPath == null
                              ? SizedBox.shrink()
                              : Image.network(
                                  ApiClient.imageUrl(posterPath as String),
                                  width: 95,
                            alignment: Alignment.centerLeft,
                                ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20,),
                                Text(
                                  movie.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  model.stringDate(movie.releaseDate),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  movie.overview,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => model.onMovieTap(context, index),
                      ),
                    ),
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              isCollapsed: true,
              contentPadding: EdgeInsets.all(12),
              fillColor: Colors.white.withAlpha(220),
              labelText: 'Поиск',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
