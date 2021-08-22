import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:peliculas_reversionado/widgets/serie/widgets.dart';
//import 'package:peliculas_reversionado/utilities/utilities_format.dart';
import 'package:provider/provider.dart';

class SerieDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Serie serie = ModalRoute.of(context)!.settings.arguments as Serie;
    // ignore: unused_local_variable
    final seriesProvider = Provider.of<SeriesProvider>(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _SerieCustomAppBar(serie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 10.0),
          SerieDetailsWidget(serie.id),
          SizedBox(height: 10.0),
          SerieGenreWidget(serie.id),
          _SerieOverview(serie),
          SizedBox(height: 5.0),
          SerieCastingCards(serie.id),
          SerieSimilarSlider(serie.id)
        ]))
      ],
    ));
  }
}

class _SerieCustomAppBar extends StatelessWidget {
  final Serie serie;

  const _SerieCustomAppBar(this.serie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black38,
          child: Text(
            serie.name.toUpperCase(),
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: CachedNetworkImage(
          imageUrl: serie.fullBackdropPath,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            child: Center(child: CupertinoActivityIndicator()),
          ),
        ),
      ),
    );
  }
}

class _SerieOverview extends StatelessWidget {
  final Serie serie;

  const _SerieOverview(this.serie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        serie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
