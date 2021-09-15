import 'package:flutter/material.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/library/inherited/provider.dart';
import 'package:the_movie/ui/widgets/tv_series/tv_series_list_widget_model.dart';

class TvSeriesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvSeriesListWidgetModel>(context);
    if (model == null) return SizedBox.shrink();
    return Stack(
      children: [
        model.tvSeries.isEmpty ? Center(child: CircularProgressIndicator(strokeWidth: 2,),) :
        ListView.builder(
            physics: BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(top: 50),
            itemExtent: 163,
            itemCount: model.tvSeries.length,
            itemBuilder: (BuildContext context, int index) {
              model.showedMoviesIndex(index);
              final tvSeries = model.tvSeries[index];
              final posterPath = tvSeries.posterPath;
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
                          tvSeries.posterPath == null
                              ? SizedBox.shrink()
                              : Image.network(
                            ApiClient.imageUrl(posterPath as String),
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20,),
                                Text(
                                  tvSeries.name,
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
                                  model.stringDate(tvSeries.firstAirDate),
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
                                  tvSeries.overview,
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
            onChanged: model.searchMovie,
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
