import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/styles/styles_of_app_widget.dart';
import 'package:the_movie/ui/widgets/movie_details/movie_detail_start_widget.dart';
import 'package:the_movie/ui/widgets/movie_list/movies_images.dart';

class MovieDetailsWidget extends StatelessWidget {
  final int id;

  MovieDetailsWidget({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StylesOFAppWidget.colorOfAppBar,
        centerTitle: true,
        elevation: 10,
        leading: Icon(Icons.menu),
        title: Text(
          'Mortal Kombat ',
          style: TextStyle(color: Colors.blue[200]),
        ),
      ),
      body: ColoredBox(
        color: Color.fromRGBO(10, 7, 8, 1.0),
        child: ListView(
          children: [
            MovieDetailStart(),
            SizedBox(
              height: 25,
            ),
            titleOfMovieDetail(),
            SizedBox(height: 20),
            buttonsOfMovieDetail(),
            SizedBox(height: 20),
            janrOfMovieDetail(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: descriptionMovieDetail(),
            ),
            MovieActorsListWidget(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Container janrOfMovieDetail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      color: Color.fromRGBO(10, 1, 5, 1.0),
      width: double.infinity,
      child: Text(
        '|R| 23/04/2021 (US) . 1h 50m  боевик, фэнтези, приключения',
        style: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Row buttonsOfMovieDetail() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.score_outlined), Text('User score')],
            )),
        Container(
          width: 2,
          height: 15,
          color: Colors.grey,
        ),
        TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.play_arrow), Text('Play')],
            )),
      ],
    );
  }
}

class MovieActorsListWidget extends StatelessWidget {
  const MovieActorsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'В главных ролях',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 250,
            color: Colors.white,
            child: Scrollbar(
              isAlwaysShown: true,
              interactive: true,
              radius: Radius.circular(15),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemExtent: 155,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.4, color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset.zero, // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: MoviesImages.acter,
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Lewis Tan ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Cole Young',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 40,),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}

class descriptionMovieDetail extends StatelessWidget {
  const descriptionMovieDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get over here.',
          style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: Colors.white60),
        ),
        SizedBox(height: 20),
        Text(
          'Обзор',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Text(
          'Боец смешанных единоборств Коул Янг не раз '
          'соглашался проиграть за деньги. Он не знает '
          'о своем наследии и почему император Внешнего '
          'мира Шан Цзун посылает могущественного криомансера '
          'Саб-Зиро на охоту за Коулом. Янг боится за безопасность '
          'своей семьи, и майор спецназа Джакс, обладатель такой '
          'же отметки в виде дракона, как и у Коула, советует ему'
          ' отправиться на поиски Сони Блейд. Вскоре Коул, Соня и'
          ' наёмник Кано оказываются в храме Лорда Рейдена, Старшего '
          'Бога и защитника Земного царства, который дает убежище '
          'тем, кто носит метку. Здесь прибывшие тренируются с опытными '
          'воинами Лю Каном и Кун Лао, готовясь противостоять врагам из'
          ' Внешнего мира, а для этого им нужно раскрыть в себе аркану —'
          ' могущественную силу души.',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }
}

class titleOfMovieDetail extends StatelessWidget {
  const titleOfMovieDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Text(
          'Мортал Комбат',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        Text(' (2021)',
            maxLines: 1, style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
