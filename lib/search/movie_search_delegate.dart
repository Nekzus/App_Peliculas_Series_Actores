import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:provider/provider.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar película';

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
          child: Icon(Icons.movie_creation_outlined,
              color: Colors.black45, size: 130)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    moviesProvider.getSuggestionsByQueryMovie(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'searchMovie-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: CachedNetworkImage(
          imageUrl: movie.fullPosterImg,
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
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'detailsMovie', arguments: movie);
      },
    );
  }
}
