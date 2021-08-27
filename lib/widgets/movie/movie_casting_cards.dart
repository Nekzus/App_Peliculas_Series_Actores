import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 205,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 5),
          width: double.infinity,
          height: 205,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: Text('Actores'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'muli'))),
              SizedBox(height: 5.0),
              Expanded(
                child: ListView.builder(
                    itemCount: cast.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) => _CastCard(cast[index])),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    actor.heroId = 'castMovieSlider-${actor.id}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: 100,
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detailsPersonMovie',
                arguments: actor),
            child: Hero(
              tag: actor.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                child: CachedNetworkImage(
                  imageUrl: actor.fullProfilePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'muli',
              )),
          Text(actor.character!.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'muli',
              ))
        ],
      ),
    );
  }
}
