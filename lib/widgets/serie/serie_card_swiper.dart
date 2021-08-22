import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas_reversionado/models/serie/models.dart';
import 'package:peliculas_reversionado/models/serie/serie.dart';

class SerieCardSwiper extends StatelessWidget {
  final List<Serie> series;

  const SerieCardSwiper({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (this.series.length == 0) {
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
        itemCount: series.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.65,
        itemHeight: size.height * 0.52,
        itemBuilder: (_, int index) {
          final serie = series[index];

          serie.heroId = 'swiperSerie-${serie.id}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detailsSerie', arguments: serie),
            child: Hero(
              tag: serie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: serie.fullPosterImg,
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
