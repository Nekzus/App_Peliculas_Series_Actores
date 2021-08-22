import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:provider/provider.dart';

class SerieGenreWidget extends StatelessWidget {
  final int serieId;

  const SerieGenreWidget(this.serieId);

  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    return FutureBuilder(
      future: seriesProvider.getSerieGenre(serieId),
      builder: (_, AsyncSnapshot<List<GenreSerie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 37,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<GenreSerie> genres = snapshot.data!;
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
                    GenreSerie genre = genres[index];
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
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
