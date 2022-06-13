import 'package:cine_view/models/Movie.dart';
import 'package:cine_view/screens/movies/arc_banner_image.dart';
import 'package:flutter/material.dart';


class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader(this.movie);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.name,
          style: textTheme.headline6,
        ),
        // SizedBox(height: 8.0),
        // RatingInformation(movie),
        // SizedBox(height: 12.0),
        // Row(children: _buildCategoryChips(textTheme)),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage(movie.img),
        ),
        // Positioned(
        //   bottom: 0.0,
        //   left: 16.0,
        //   right: 16.0,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       Poster(
        //         movie.posterUrl,
        //         height: 180.0,
        //       ),
        //       SizedBox(width: 16.0),
        //       Expanded(child: movieInformation),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}