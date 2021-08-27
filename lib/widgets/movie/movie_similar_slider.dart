import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSimilarSlider extends StatefulWidget {
  final int moviesId;

  const MovieSimilarSlider(this.moviesId);

  @override
  _MovieSimilarSliderState createState() => _MovieSimilarSliderState();
}

class _MovieSimilarSliderState extends State<MovieSimilarSlider> {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getSimilarMovies(widget.moviesId),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 235,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        final List<Movie> similar = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: 235,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: Text('Películas Similares'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'muli'))),
              SizedBox(height: 5.0),
              Expanded(
                child: ListView.builder(
                    itemCount: similar.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) =>
                        _SimilarPoster(similar[index])),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SimilarPoster extends StatelessWidget {
  final Movie movie;

  const _SimilarPoster(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'similarSlider-${movie.id}';
    return Container(
      width: 100,
      height: 139,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detailsMovie', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
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
          ),
          SizedBox(height: 5),
          Text(movie.title.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, fontFamily: 'muli')),
          Container(
              padding: EdgeInsets.only(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  SizedBox(width: 3.0),
                  Text(movie.voteAverage, style: TextStyle(fontSize: 11.0)),
                ],
              ))
        ],
      ),
    );
  }
}
