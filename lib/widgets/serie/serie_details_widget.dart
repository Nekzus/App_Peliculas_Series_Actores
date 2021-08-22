import 'package:cached_network_image/cached_network_image.dart';
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
              constraints: BoxConstraints(maxWidth: 150),
              height: 210,
              child: CupertinoActivityIndicator(),
            );
          }

          final SerieDetails series = snapshot.data!;
          final Serie serie =
              ModalRoute.of(context)!.settings.arguments as Serie;
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            height: 210,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _SeriePoster(serie),
              Container(
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
                            'Título Original: '.toUpperCase() +
                                series.originalName.toUpperCase(),
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
                          'Primer Episodio: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(series.firstAirDate!))}'
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
                          'Último Episodio: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(series.lastAirDate!))}'
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
                              Text(series.voteAverage,
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
              )
            ]),
          );
        });
  }
}

class _SeriePoster extends StatelessWidget {
  final Serie serie;

  const _SeriePoster(this.serie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: serie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: serie.fullPosterImg,
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
        ],
      ),
    );
  }
}
