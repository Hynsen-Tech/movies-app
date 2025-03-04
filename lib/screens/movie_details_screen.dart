import 'package:flutter/material.dart';
import 'package:mvvm_state_management/constants/api_constants.dart';
import 'package:mvvm_state_management/widgets/cached_image_widget.dart';
import 'package:mvvm_state_management/widgets/movies/favorite_btn_widget.dart';
import 'package:mvvm_state_management/widgets/movies/genres_list_widget.dart';
import '../models/movie_model.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/rating_widget.dart';
import '../widgets/release_date_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.65,
              child: CachedImageWidget(
                imgUrl: "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                imgWidth: double.infinity,
                imgHeight: double.infinity,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.45,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Material(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingWidget(
                                        voteAverage: movie.voteAverage.round()),
                                    ReleaseDateWidget(
                                        releaseDate: movie.releaseDate),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                GenresListWidget(
                                  genreIds: movie.genreIds,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  movie.overview,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child:
                                FavoriteBtnWidget(movie: movie, iconSize: 30),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 7,
              left: 5,
              child: BackButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
