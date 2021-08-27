import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:provider/provider.dart';

class SerieDetailsWidget extends StatelessWidget {
  final int serieId;

  const SerieDetailsWidget(this.serieId);

  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: seriesProvider.getSerieDetails(serieId),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: 230,
              height: 210,
              child: Center(child: CupertinoActivityIndicator()),
            );
          }

          final SerieDetails series = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            height: 210,
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
                              series.originalName!.toUpperCase(),
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
                        'Estado: '.toUpperCase() +
                            series.fullStatus.toUpperCase(),
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
                        'Idioma Original: '.toUpperCase() +
                            series.fullOriginalLanguage.toUpperCase(),
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
                        'Temporadas: '.toUpperCase() +
                            series.numberOfSeasons.toString(),
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
                        'Episodios: '.toUpperCase() +
                            series.numberOfEpisodes.toString(),
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
                        'Primer Episodio: '.toUpperCase() +
                            (DateFormat('dd-MM-yyyy')
                                .format(series.firstAirDate!)),
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
                        'Último Episodio: '.toUpperCase() +
                            (DateFormat('dd-MM-yyyy')
                                .format(series.lastAirDate!)),
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
                            Text(series.voteAverage!,
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
}
