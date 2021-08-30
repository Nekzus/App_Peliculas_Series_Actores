import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SerieNetworkWidget extends StatefulWidget {
  final int seriesId;

  const SerieNetworkWidget(this.seriesId);

  @override
  _SerieNetworkWidgetState createState() => _SerieNetworkWidgetState();
}

class _SerieNetworkWidgetState extends State<SerieNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    return FutureBuilder(
      future: seriesProvider.getSerieDetails(widget.seriesId),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 100,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        final SerieDetails networks = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                  child: Text('Emitido por'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'muli'))),
              Expanded(
                child: ListView.builder(
                    itemCount: networks.networks.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) => _SerieNetworkPoster(
                        networks.networks[index], networks)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SerieNetworkPoster extends StatelessWidget {
  final Network network;
  final SerieDetails homepage;

  const _SerieNetworkPoster(this.network, this.homepage);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => launch(homepage.homepage!),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.white.withOpacity(0.3),
                child: CachedNetworkImage(
                  imageUrl: network.fullLogoPath,
                  width: 70,
                  height: 40,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(
                    width: 70,
                    height: 40,
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(network.name!.toUpperCase(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, fontFamily: 'muli')),
        ],
      ),
    );
  }
}
