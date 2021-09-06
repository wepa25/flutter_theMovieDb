import 'package:flutter/material.dart';
import 'package:the_movie/ui/navigation/main_navigation.dart';
import 'package:the_movie/ui/widgets/movie_list/movies_images.dart';

class Movies {
  final int id;
  final AssetImage imageName;
  final String title;
  final String time;
  final String description;

  Movies(
      {required this.id,
      required this.imageName,
      required this.title,
      required this.time,
      required this.description});
}

class MovieListWidget extends StatefulWidget {
  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movies(
        id: 1,
        imageName: MoviesImages.mortal,
        title: 'Мортал Комбат',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 2,
        imageName: MoviesImages.mortal,
        title: 'Доспехи Бога',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 3,
        imageName: MoviesImages.mortal,
        title: 'Кто я',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 4,
        imageName: MoviesImages.mortal,
        title: 'Наследие',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 5,
        imageName: MoviesImages.mortal,
        title: 'Кунг фу панда',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 6,
        imageName: MoviesImages.mortal,
        title: 'Шаг в перед',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 7,
        imageName: MoviesImages.mortal,
        title: 'Неудержимые',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 8,
        imageName: MoviesImages.mortal,
        title: 'Форсаж',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
    Movies(
        id: 9,
        imageName: MoviesImages.mortal,
        title: 'Такси',
        time: '7 апреля 2021',
        description: 'Боец смешанных единоборств Коул Янг не раз соглашался'
            ' проиграть за деньги.'),
  ];

  final searchController = TextEditingController();
  var _filtredMovies = <Movies>[];

  void searchMovie() {
    var query = searchController.text;
    if (query.isNotEmpty) {
      _filtredMovies = _movies.where((Movies movies) {
        return movies.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filtredMovies = _movies;
    }
    setState(() {});
  }

 void _onMovieTap(int index){
    final id = _filtredMovies[index].id;
    Navigator.of(context).pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  @override
  void initState() {
    super.initState();
    _filtredMovies = _movies;
    searchController.addListener(searchMovie);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(top: 50),
            itemExtent: 123,
            itemCount: _filtredMovies.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = _filtredMovies[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.4, color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image(image: movie.imageName),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                  movie.time,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  movie.description,
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
                        onTap: () => _onMovieTap(index),
                      ),
                    ),
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            controller: searchController,
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
