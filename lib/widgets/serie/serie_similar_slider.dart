import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:provider/provider.dart';

class SerieSimilarSlider extends StatefulWidget {
  final int seriesId;

  const SerieSimilarSlider(this.seriesId);

  @override
  _SerieSimilarSliderState createState() => _SerieSimilarSliderState();
}

class _SerieSimilarSliderState extends State<SerieSimilarSlider> {
  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    return FutureBuilder(
      future: seriesProvider.getSimilarSeries(widget.seriesId),
      builder: (_, AsyncSnapshot<List<Serie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 235,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Serie> similar = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: 235,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: Text('Similares'.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle2)),
              SizedBox(height: 5.0),
              Expanded(
                child: ListView.builder(
                    itemCount: similar.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) =>
                        _SerieSimilarPoster(similar[index])),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SerieSimilarPoster extends StatelessWidget {
  final Serie serie;

  const _SerieSimilarPoster(this.serie);

  @override
  Widget build(BuildContext context) {
    serie.heroId = 'similarSlider-${serie.id}';
    return Container(
      width: 100,
      height: 139,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detailsSerie', arguments: serie),
            child: Hero(
              tag: serie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
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
          ),
          SizedBox(height: 5),
          Text(serie.name.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, fontFamily: 'muli')),
          Container(
              padding: EdgeInsets.only(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 11.5,
                  ),
                  SizedBox(width: 3.0),
                  Text(serie.voteAverage, style: TextStyle(fontSize: 11.0)),
                ],
              ))
        ],
      ),
    );
  }
}
