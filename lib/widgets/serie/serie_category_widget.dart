import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:peliculas_reversionado/helpers/serie/helpers.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';

class BuildWidgetCategorySerie extends StatefulWidget {
  final int selectedGenre;

  const BuildWidgetCategorySerie({Key? key, this.selectedGenre = 10759})
      : super(key: key);

  @override
  BuildWidgetCategorySerieState createState() =>
      BuildWidgetCategorySerieState();
}

class BuildWidgetCategorySerieState extends State<BuildWidgetCategorySerie> {
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
        BlocProvider<SerieBloc>(
          create: (_) =>
              SerieBloc()..add(SerieEventStarted(selectedGenre!, '')),
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
                                selectedGenre = genre.id;
                                context
                                    .read<SerieBloc>()
                                    .add(SerieEventStarted(selectedGenre!, ''));
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
                                genre.name!.toUpperCase(),
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
              child: Text('Series x Género'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2)),
          BlocBuilder<SerieBloc, SerieState>(
            builder: (context, state) {
              if (state is SerieLoading) {
                return Center();
              } else if (state is SerieLoaded) {
                List<SerieGenre> serieList = state.serieList;

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
                          itemCount: serieList.length,
                          itemBuilder: (context, index) {
                            SerieGenre serie = serieList[index];

                            serie.heroId = 'categorySerie-${serie.id}';

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'detailsCategorySerie',
                                        arguments: serie);
                                  },
                                  child: Hero(
                                    tag: serie.heroId!,
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${serie.fullPosterImg}',
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
                                    serie.name.toUpperCase(),
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
                                      Text(serie.voteAverage,
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
