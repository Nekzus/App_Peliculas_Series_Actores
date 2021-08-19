import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';
//import 'package:peliculas_reversionado/utilities/utilities_format.dart';
import 'package:peliculas_reversionado/widgets/movie/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    // ignore: unused_local_variable
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(movie),
          SizedBox(height: 10.0),
          MovieGenreWidget(movie.id),
          _Overview(movie),
          SizedBox(height: 5.0),
          CastingCards(movie.id),
          MovieSimilarSlider(movie.id)
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black38,
          child: Text(
            movie.title.toUpperCase(),
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: CachedNetworkImage(
          imageUrl: movie.fullBackdropPath,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            child: Center(child: CupertinoActivityIndicator()),
          ),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: movie.fullPosterImg,
                width: 100,
                height: 139,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100,
                  height: 139,
                  child: Center(child: CupertinoActivityIndicator()),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 195),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    style: textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text(
                    'Estreno: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(movie.releaseDate!))}',
                    //UtilidadFecha.formatDate(movie.releaseDate!, 'yyyy'),
                    style: TextStyle(fontSize: 15.0),
                    overflow: TextOverflow.ellipsis),
                Text('Idioma Origen: ' + movie.fullOriginalLanguage,
                    style: TextStyle(fontSize: 15.0),
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 17.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 17.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 17.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 17.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 17.0,
                    ),
                    SizedBox(width: 5.0),
                    Text(movie.voteAverage, style: TextStyle(fontSize: 15.0))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
