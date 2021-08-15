import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_reversionado/helpers/movie/helpers.dart';

import 'package:peliculas_reversionado/models/movie/models.dart';
import 'package:peliculas_reversionado/providers/movies_provider.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GenreEventStarted) {
      yield* _mapMovieEventStateToState();
    }
  }

  Stream<GenreState> _mapMovieEventStateToState() async* {
    final service = MoviesProvider();
    yield GenreLoading();
    try {
      List<Genre> genreList = await service.getGenreList();

      yield GenreLoaded(genreList);
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      yield GenreError();
    }
  }
}
