import 'package:equatable/equatable.dart';

abstract class SerieEvent extends Equatable {
  const SerieEvent();
}

class SerieEventStarted extends SerieEvent {
  final int serieId;
  final String query;

  const SerieEventStarted(this.serieId, this.query);

  @override
  List<Object> get props => [];
}
