import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';
import 'package:peliculas_reversionado/screens/movie/screens.dart';
import 'package:peliculas_reversionado/search/movie_search_delegate.dart';
import 'package:peliculas_reversionado/widgets/movie/card_swiper.dart';
import 'package:peliculas_reversionado/widgets/movie/widgets.dart';
import 'package:provider/provider.dart';

class MovieHomeScreen extends StatefulWidget {
  @override
  _MovieHomeScreenState createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen>
    with AutomaticKeepAliveClientMixin<MovieHomeScreen> {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: Icon(Icons.search_outlined))
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Tarjetas principales
          SizedBox(height: 90),
          CardSwiper(movies: moviesProvider.onDisplayMovies),
          SizedBox(height: 10),
          BuildWidgetCategory(),
          // Slider de peliculas_reversionado
          MovieSlider(
              movies: moviesProvider.popularMovies,
              onNextPage: () => moviesProvider.getPopularMovies()),
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
