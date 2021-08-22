import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieGenreWidget extends StatelessWidget {
  final int movieId;

  const MovieGenreWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieGenre(movieId),
      builder: (_, AsyncSnapshot<List<GenreMovie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 37,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<GenreMovie> genres = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 5),
          width: double.infinity,
          height: 37,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: genres.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    GenreMovie genre = genres[index];
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: Colors.black45),
                          child: Text(
                            genre.fullGenreName.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'muli',
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
