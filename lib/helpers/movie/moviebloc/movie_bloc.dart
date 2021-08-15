import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:peliculas_reversionado/helpers/movie/helpers.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(
      int movieId, String query) async* {
    final service = MoviesProvider();
    yield MovieLoading();
    try {
      List<MovieGenre> movieList;
      if (movieId == 0) {
        movieList = await service.getNowPlayingMovie();
      } else {
        movieList = await service.getMovieByGenre(movieId);
      }

      yield MovieLoaded(movieList);
    // ignore: unused_catch_clause
    } on Exception catch (e) {
      yield MovieError();
    }
  }
}
