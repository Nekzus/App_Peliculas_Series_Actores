import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peliculas_reversionado/helpers/serie/helpers.dart';

import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';

class SerieBloc extends Bloc<SerieEvent, SerieState> {
  SerieBloc() : super(SerieLoading());

  @override
  Stream<SerieState> mapEventToState(SerieEvent event) async* {
    if (event is SerieEventStarted) {
      yield* _mapMovieEventStateToState(event.serieId, event.query);
    }
  }

  Stream<SerieState> _mapMovieEventStateToState(
      int serieId, String query) async* {
    final service = SeriesProvider();
    yield SerieLoading();
    try {
      List<SerieGenre> serieList;
      if (serieId == 0) {
        serieList = await service.getNowPlayingSerie();
      } else {
        serieList = await service.getSerieByGenre(serieId);
      }

      yield SerieLoaded(serieList);
    // ignore: unused_catch_clause
    } on Exception catch (e) {
      yield SerieError();
    }
  }
}
