import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:peliculas_reversionado/helpers/movie/helpers.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;

  const BuildWidgetCategory({Key? key, this.selectedGenre = 28})
      : super(key: key);

  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  int? selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext conte) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenreBloc>(
          create: (_) => GenreBloc()..add(GenreEventStarted()),
        ),
        BlocProvider<MovieBloc>(
          create: (_) =>
              MovieBloc()..add(MovieEventStarted(selectedGenre!, '')),
        ),
      ],
      child: _buildGenre(context),
    );
  }

  Widget _buildGenre(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              if (state is GenreLoading) {
                return Center(
                  child: Platform.isAndroid
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                );
              } else if (state is GenreLoaded) {
                List<Genre> genres = state.genreList;
                return Container(
                  height: 37,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        VerticalDivider(
                      color: Colors.transparent,
                      width: 5,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      Genre genre = genres[index];
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Genre genre = genres[index];
                                selectedGenre = genre.id!;
                                context
                                    .read<MovieBloc>()
                                    .add(MovieEventStarted(selectedGenre!, ''));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                color: (genre.id == selectedGenre)
                                    ? Colors.black45
                                    : Colors.white,
                              ),
                              child: Text(
                                genre.fullGenreName.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: (genre.id == selectedGenre)
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: 'muli',
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 10.0),
              child: Text('Películas x Género'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2)),
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return Center();
              } else if (state is MovieLoaded) {
                List<MovieGenre> movieList = state.movieList;

                return Container(
                  width: double.infinity,
                  height: 207,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => VerticalDivider(
                            color: Colors.transparent,
                            width: 15,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: movieList.length,
                          itemBuilder: (context, index) {
                            MovieGenre movie = movieList[index];

                            movie.heroId = 'categoryMovie-${movie.id}';

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'detailsCategoryMovie',
                                        arguments: movie);
                                  },
                                  child: Hero(
                                    tag: movie.heroId!,
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            width: 100,
                                            height: 139,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 100,
                                          height: 139,
                                          child: Center(
                                            child: Platform.isAndroid
                                                ? CupertinoActivityIndicator()
                                                : CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          width: 100,
                                          height: 139,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/no-image.jpg'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'muli',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
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
                                      Text(movie.voteAverage,
                                          style: TextStyle(fontSize: 11.0)),
                                    ],
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
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
