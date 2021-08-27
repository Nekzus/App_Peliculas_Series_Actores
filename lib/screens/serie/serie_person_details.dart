import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:peliculas_reversionado/widgets/movie/widgets.dart';
import 'package:peliculas_reversionado/widgets/serie/widgets.dart';
import 'package:provider/provider.dart';

class DetailsPersonSerieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cast actor = ModalRoute.of(context)!.settings.arguments as Cast;
    // ignore: unused_local_variable
    final seriesProvider = Provider.of<SeriesProvider>(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(actor),
        SliverList(
            delegate: SliverChildListDelegate([
          _MoviePosterDetailsCategory(actor),
          SizedBox(height: 10.0),
          PersonSerieSimilarSlider(actor.id),
          SizedBox(height: 10.0),
          PersonSimilarSlider(actor.id),
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Cast actor;

  const _CustomAppBar(this.actor);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black.withOpacity(0.2),
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
            actor.name.toUpperCase(),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'muli'),
            textAlign: TextAlign.center,
          ),
        ),
        background: Hero(
          tag: actor.heroId!,
          child: CachedNetworkImage(
            imageUrl: actor.fullProfilePath,
            fit: BoxFit.contain,
            placeholder: (context, url) => Container(
              child: Center(child: CupertinoActivityIndicator()),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoviePosterDetailsCategory extends StatelessWidget {
  final Cast actor;

  const _MoviePosterDetailsCategory(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [PersonSerieDetailsWidget(actor.id)],
      ),
    );
  }
}
