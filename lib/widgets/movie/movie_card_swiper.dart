import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas_reversionado/models/movie/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (this.movies.length == 0) {
      return Container(
          width: double.infinity,
          height: size.height * 0.55,
          child: Center(child: CupertinoActivityIndicator()));
    }

    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Swiper(
        scrollDirection: Axis.horizontal,
        autoplay: true,
        autoplayDelay: 5000,
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.65,
        itemHeight: size.height * 0.52,
        itemBuilder: (_, int index) {
          final movie = movies[index];

          movie.heroId = 'swiperMovie-${movie.id}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detailsMovie', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: movie.fullPosterImg,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
