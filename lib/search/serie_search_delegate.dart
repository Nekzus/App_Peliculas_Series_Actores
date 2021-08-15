import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:provider/provider.dart';

class SerieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar serie';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
          child: Icon(Icons.tv_outlined, color: Colors.black45, size: 130)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    seriesProvider.getSuggestionsByQuerySerie(query);

    return StreamBuilder(
      stream: seriesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Serie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final series = snapshot.data!;

        return ListView.builder(
            itemCount: series.length,
            itemBuilder: (_, int index) => _SerieItem(series[index]));
      },
    );
  }
}

class _SerieItem extends StatelessWidget {
  final Serie serie;

  const _SerieItem(this.serie);

  @override
  Widget build(BuildContext context) {
    serie.heroId = 'searchSerie-${serie.id}';
    return ListTile(
      leading: Hero(
        tag: serie.heroId!,
        child: CachedNetworkImage(
          imageUrl: serie.fullPosterImg,
          width: 50,
          height: 100,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: 50,
            height: 100,
            child: Center(child: CupertinoActivityIndicator()),
          ),
        ),
      ),
      title: Text(serie.name),
      subtitle: Text(serie.originalName),
      onTap: () {
        Navigator.pushNamed(context, 'detailsSerie', arguments: serie);
      },
    );
  }
}
