import 'package:equatable/equatable.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';

abstract class SerieState extends Equatable {
  const SerieState();

  @override
  List<Object> get props => [];
}

class SerieLoading extends SerieState {}

class SerieLoaded extends SerieState {
  final List<SerieGenre> serieList;
  const SerieLoaded(this.serieList);

  @override
  List<Object> get props => [serieList];
}

class SerieError extends SerieState {}
