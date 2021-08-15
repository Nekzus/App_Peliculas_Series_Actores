import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key,
    required this.movies,
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 235,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text('Películas Populares'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2)),
          SizedBox(height: 5.0),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) => _MoviePoster(
                    widget.movies[index],
                    '${widget.title}-$index-${widget.movies[index].id}')),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 100,
      height: 139,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detailsMovie', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: movie.fullPosterImg,
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
          Text(movie.title.toUpperCase(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'muli')),
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
                  Text(movie.voteAverage, style: TextStyle(fontSize: 11.0)),
                ],
              ))
        ],
      ),
    );
  }
}
