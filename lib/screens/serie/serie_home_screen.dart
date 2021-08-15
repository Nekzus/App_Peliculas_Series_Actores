import 'package:flutter/material.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:peliculas_reversionado/search/serie_search_delegate.dart';
import 'package:peliculas_reversionado/widgets/serie/widgets.dart';
import 'package:provider/provider.dart';

class SerieHomeScreen extends StatefulWidget {
  @override
  _SerieHomeScreenState createState() => _SerieHomeScreenState();
}

class _SerieHomeScreenState extends State<SerieHomeScreen>
    with AutomaticKeepAliveClientMixin<SerieHomeScreen> {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: SerieSearchDelegate()),
              icon: Icon(Icons.search_outlined))
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 90),
          // Tarjetas principales
          SerieCardSwiper(series: seriesProvider.onDisplaySeries),
          SizedBox(height: 10),
          BuildWidgetCategorySerie(),
          // Slider de peliculas_reversionado
          SerieSlider(
            series: seriesProvider.popularSeries,
            onNextPage: () => seriesProvider.getPopularSeries(),
          )
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
