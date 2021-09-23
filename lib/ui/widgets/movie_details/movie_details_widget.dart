import 'package:flutter/material.dart';
import 'package:the_movie/domain/api_client/api_client.dart';
import 'package:the_movie/domain/entity/movie_details/movie_details.dart';
import 'package:the_movie/domain/entity/movie_details/movie_details_credits.dart';
import 'package:the_movie/library/inherited/provider.dart';
import 'package:the_movie/styles/styles_of_app_widget.dart';
import 'package:the_movie/ui/widgets/movie_details/movie_detail_start_widget.dart';
import 'package:the_movie/ui/widgets/movie_details/radial_percent_widget.dart';
import 'package:the_movie/ui/widgets/movie_list/movies_images.dart';

import 'movie_detail_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<MovieDetailModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    //   final model = NotifierProvider.watch<MovieDetailModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StylesOFAppWidget.colorOfAppBar,
        centerTitle: true,
        elevation: 10,
        title: const TitleOfAppBar(),
      ),
      body: ColoredBox(
        color: Color.fromRGBO(19, 20, 36, 1.0),
        child: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
    return model?.movieDetails == null
        ? Center(
        child: const CircularProgressIndicator(
          strokeWidth: 1,
        ))
        : ListView(
      children: [
    MovieDetailStart(),
    SizedBox(
    height: 25,
    ),
    NameOfMovieWidget(),
    SizedBox(height: 10),
    ButtonsOfMovieDetail(),
    SizedBox(height: 10),
    JanrOfMovieDetail(),
    SizedBox(height: 5),
    Padding(
    padding:
    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: DescriptionMovieDetail(),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 20),
    child: MovieEmpleyesWidget(),
    ),
    MovieActorsListWidget(),
    SizedBox(height: 30),
    ],
    );
  }
}

class TitleOfAppBar extends StatelessWidget {
  const TitleOfAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider?.watch<MovieDetailModel>(context);
    return Text(
      model?.movieDetails?.title ?? 'Loading...',
      style: TextStyle(color: Colors.blue[200]),
    );
  }
}

class NameOfMovieWidget extends StatelessWidget {
  const NameOfMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
    final name = model?.movieDetails?.title ?? '';
    final date = model?.movieDetails?.releaseDate ?? null;
    var year = date?.year;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        Text(' ($year)',
            maxLines: 1, style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}

class ButtonsOfMovieDetail extends StatelessWidget {
  const ButtonsOfMovieDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
    var voteAverage = model?.movieDetails?.voteAverage ?? 0;
    var vote = voteAverage * 10;
    return Center(
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {},
              child: Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RadialPercentWidget(
                      percent: vote / 100,
                      fillColor: Color.fromARGB(255, 10, 23, 25),
                      lineColor: Color.fromARGB(255, 37, 203, 103),
                      freeColor: Color.fromARGB(255, 25, 54, 31),
                      lineWidth: 3,
                      child: Text(
                        vote.toStringAsFixed(0),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'User Score',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
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
                children: [
                  Icon(
                    Icons.play_arrow,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Play Trailer',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class JanrOfMovieDetail extends StatelessWidget {
  const JanrOfMovieDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
    var text = <String>[];

    final releaseDate = model?.movieDetails?.releaseDate;
    if (releaseDate != null) {
      text.add(model!.stringDate(releaseDate));
    }else {
      SizedBox.shrink();
    }
    final productionCountries =
        model?.movieDetails?.productionCountries.first.iso ?? '';
    text.add('($productionCountries)');
    final runtime = model?.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    text.add('${hours}h ${minutes}m');
    final genres = model?.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      text.add(genresNames.join(', '));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      color: Color.fromRGBO(10, 9, 23, 1.0),
      width: double.infinity,
      child: Text(
        text.join(' '),
        style: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class DescriptionMovieDetail extends StatelessWidget {
  const DescriptionMovieDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
     final overview = model?.movieDetails?.overview;
    if (overview == null || overview.isEmpty ){
       return SizedBox.shrink();
    }else
      {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Обзор',
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Text(
              model?.movieDetails?.overview ?? '',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
            ),
            SizedBox(height: 20),
          ],
        );
      }

  }
}

class MovieEmpleyesWidget extends StatelessWidget {
  const MovieEmpleyesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    final crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: crewChunks.map((employee) =>
            EmployeeRowWidget(employeList: employee,)).toList(),
    );
  }
}

class EmployeeRowWidget extends StatelessWidget {
  final List<Employee> employeList;

  const EmployeeRowWidget({Key? key, required this.employeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: employeList.map((e) => EmployeeItemWidget(employes: e,)).toList(),
    );
  }
}

class EmployeeItemWidget extends StatelessWidget {
  final Employee employes;
  const EmployeeItemWidget({Key? key , required this.employes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employes.name, style: TextStyle(color: Colors.white),),
            Text(employes.job, style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
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
            height: 280,
            color: Colors.white,
            child: Scrollbar(
              interactive: true,
              radius: Radius.circular(15),
              child: MovieActorsListItemWidget(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class MovieActorsListItemWidget extends StatelessWidget {
  const MovieActorsListItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailModel>(context);
    final cast = model?.movieDetails?.credits.cast;
    final int count;
    return cast == null || cast.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemExtent: 125,
        scrollDirection: Axis.horizontal,
        itemCount: cast.length > 10 ? 10 : cast.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieActorItemWidget(
            indexItem: index,
          );
        });
  }
}

class MovieActorItemWidget extends StatelessWidget {
  final int indexItem;

  const MovieActorItemWidget({
    Key? key,
    required this.indexItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetailModel>(context);
    final actors = model!.movieDetails!.credits.cast[indexItem];
    final profilePath = model.movieDetails!.credits.cast[indexItem].profilePath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: Container(
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
                  //Image(image: MoviesImages.acter),
                  profilePath == null || profilePath.isEmpty
                      ? SizedBox(
                    height: 140,
                    width: 140,
                    child: Image(
                      image: MoviesImages.holder,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  )
                      : SizedBox(
                      height: 140,
                      width: 140,
                      child: Image.network(
                        ApiClient.imageUrl(profilePath),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      actors.name,
                      maxLines: 2,
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
                      actors.character,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
