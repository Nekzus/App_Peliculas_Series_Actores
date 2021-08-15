import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:provider/provider.dart';

class SerieCastingCards extends StatelessWidget {
  final int serieId;

  const SerieCastingCards(this.serieId);

  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    return FutureBuilder(
      future: seriesProvider.getSerieCast(serieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 205,
            child: CupertinoActivityIndicator(),
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
                      style: Theme.of(context).textTheme.subtitle2)),
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: 100,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
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
