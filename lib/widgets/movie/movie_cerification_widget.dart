import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieCerificationWidget extends StatelessWidget {
  final int movieId;

  const MovieCerificationWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: moviesProvider.getMovieCertifications(movieId),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: 400,
              height: 100,
              child: Center(child: CupertinoActivityIndicator()),
            );
          }

          final ReleaseDate movies = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Container(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          'Nacimiento: ${movies.certification}'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'muli',
                          ),
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
