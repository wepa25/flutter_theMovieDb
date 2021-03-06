import 'package:flutter/material.dart';
import 'package:the_movie/domain/session_data_provider/session_data_provider.dart';
import 'package:the_movie/library/inherited/provider.dart';
import 'package:the_movie/ui/widgets/main_screen/main_screen_model.dart';
import 'package:the_movie/ui/widgets/movie_list/app_movie_model.dart';
import 'package:the_movie/ui/widgets/tv_series/tv_series_list_widget.dart';
import 'package:the_movie/ui/widgets/tv_series/tv_series_list_widget_model.dart';
import '../movie_list/app_movie_widget.dart';

class MainScreenWidget extends StatefulWidget {
  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  var _selectedIndex = 0;
  final  movieListModel = MoviesListModel();
  final tvSeriesModel = TvSeriesListWidgetModel();
  static const TextStyle optionStyle =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700);

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await tvSeriesModel.setupLocale(context);
    await movieListModel.setupLocale(context);
  }


  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(

      appBar: AppBar(
        title: Text('TMDB', style: TextStyle(color: Colors.blue[200])),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => SessionDataProvider().setSessionId(null),
              icon: Icon(Icons.logout)),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Text(
            'Новости',
            style: optionStyle,
          ),
          NotifierProvider(create:() => movieListModel,isManagingModel: false,child: MovieListWidget()),
          NotifierProvider(create:() => tvSeriesModel,child: TvSeriesListWidget()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_file_move_outlined),
            label: 'Фильмы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Сериалы',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onTapIcon,
      ),
    );
  }

  void onTapIcon(int index) {
    if (index == this._selectedIndex) return;
    setState(() {
      this._selectedIndex = index;
    });
  }
}
