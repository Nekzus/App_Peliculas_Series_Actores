import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:peliculas_reversionado/screens/home_screen.dart';
import 'package:peliculas_reversionado/screens/movie/screens.dart';
import 'package:peliculas_reversionado/screens/serie/screens.dart';
import 'package:peliculas_reversionado/screens/serie/serie_details_screen.dart';
import 'package:provider/provider.dart';

import 'package:peliculas_reversionado/providers/movies_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => SeriesProvider(), lazy: false)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Películas',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeScreen(),
          'detailsMovie': (_) => DetailsScreen(),
          'detailsSerie': (_) => SerieDetailsScreen(),
          'detailsCategoryMovie': (_) => DetailsCategory(),
          'detailsCategorySerie': (_) => SerieDetailsCategoryScreen(),
          'detailsPersonMovie': (_) => DetailsPersonScreen(),
          'detailsPersonSerie': (_) => DetailsPersonSerieScreen(),
        },
        theme: ThemeData.dark()
            .copyWith(appBarTheme: AppBarTheme(color: Colors.black)));
  }
}
