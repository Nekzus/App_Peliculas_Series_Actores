import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:peliculas_reversionado/widgets/serie/widgets.dart';
import 'package:peliculas_reversionado/widgets/serie/serie_similar_slider.dart';
import 'package:provider/provider.dart';

class SerieDetailsCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SerieGenre serie =
        ModalRoute.of(context)!.settings.arguments as SerieGenre;
    // ignore: unused_local_variable
    final seriesProvider = Provider.of<SeriesProvider>(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _SerieCustomAppBar(serie),
        SliverList(
            delegate: SliverChildListDelegate([
          _SeriePosterDetailsCategory(serie),
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
  final SerieGenre serie;

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
            serie.fullGenreName.toUpperCase(),
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
  final SerieGenre serie;

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

class _SeriePosterDetailsCategory extends StatelessWidget {
  final SerieGenre serie;

  const _SeriePosterDetailsCategory(this.serie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: serie.heroId!,
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
          SizedBox(width: 15),
          SerieDetailsWidget(serie.id)
        ],
      ),
    );
  }
}
