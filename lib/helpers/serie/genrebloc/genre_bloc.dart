import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_reversionado/helpers/serie/helpers.dart';

import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GenreEventStarted) {
      yield* _mapSerieEventStateToState();
    }
  }

  Stream<GenreState> _mapSerieEventStateToState() async* {
    final service = SeriesProvider();
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
