import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas_reversionado/widgets/serie/widgets.dart';
import 'package:peliculas_reversionado/screens/movie/screens.dart';
import 'package:peliculas_reversionado/screens/serie/screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final moviesProvider = Provider.of<MoviesProvider>(context);
    //final seriesProvider = Provider.of<SeriesProvider>(context);
    //final searchTabService = MovieSearchDelegate();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          backgroundColor: Colors.black.withOpacity(0.28),
          elevation: 0,
          //title: Text('Películas-NK'.toUpperCase()),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                indicatorWeight: 3,
                indicatorColor: Colors.red,
                tabs: <Widget>[
                  Tab(text: 'Películas'.toUpperCase()),
                  Tab(text: 'Series'.toUpperCase()),
                ],
              ),
            ],
          ),
        ),
        /* actions: [
              IconButton(
                  onPressed: () =>
                      showSearch(context: context, delegate: searchTabService),
                  icon: Icon(Icons.search_outlined))
            ] */
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            MovieHomeScreen(),
            SerieHomeScreen(),
          ],
        ),
      ),
    );
  }
}
