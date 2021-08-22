import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsWidget extends StatelessWidget {
  final int movieId;

  const MovieDetailsWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: moviesProvider.getMovieDetails(movieId),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 90),
              height: 185,
              child: CupertinoActivityIndicator(),
            );
          }

          final MovieDetails movies = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            height: 185,
            child: Container(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 150),
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
                          'Original: '.toUpperCase() +
                              movies.originalTitle!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'muli',
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
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
                        'Idioma Original: '.toUpperCase() +
                            movies.fullOriginalLanguage.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'muli',
                        ),
                      ),
                    ),
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
                        'Fecha Estreno: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(movies.releaseDate!))}'
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'muli',
                        ),
                      ),
                    ),
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
                        'Duración: '.toUpperCase() +
                            _getMovieDuration(movies.runtime!),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'muli',
                        ),
                      ),
                    ),
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
                          'Presupuesto: '.toUpperCase() +
                              NumberFormat.currency(
                                      locale: 'en', decimalDigits: 0)
                                  .format(movies.budget),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'muli',
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
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
                          'Recaudación: '.toUpperCase() +
                              NumberFormat.currency(
                                      locale: 'en', decimalDigits: 0)
                                  .format(movies.revenue),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'muli',
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 11.0,
                            ),
                            SizedBox(width: 5.0),
                            Text(movies.voteAverage!,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'muli'))
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String _getMovieDuration(int runtime) {
    if (runtime == null) return '---';
    double movieHours = runtime / 60;
    int movieMinutes = ((movieHours - movieHours.floor()) * 60).round();
    return "${movieHours.floor()}h ${movieMinutes}min";
  }
}
