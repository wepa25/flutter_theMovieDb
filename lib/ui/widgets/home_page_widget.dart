import 'package:flutter/material.dart';
import 'package:the_movie/domain/session_data_provider/session_data_provider.dart';
import 'package:the_movie/styles/styles_of_app_widget.dart';
import 'movie_list/app_movie_widget.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  var _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB', style: TextStyle(color: Colors.blue[200])),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => SessionDataProvider().setSessionId(null),
              icon: Icon(Icons.logout)),
        ],
        // backgroundColor: StylesOFAppWidget.colorOfAppBar,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Text(
            'Новости',
            style: optionStyle,
          ),
          MovieListWidget(),
          Text(
            'Сериалы',
            style: optionStyle,
          ),
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
