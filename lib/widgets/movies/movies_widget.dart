import 'package:flutter/material.dart';
import 'package:mvvm_state_management/constants/api_constants.dart';
import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/screens/movie_details_screen.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/services/navigation_service.dart';
import 'package:mvvm_state_management/widgets/cached_image_widget.dart';
import 'package:mvvm_state_management/widgets/release_date_widget.dart';
import '../../constants/constants.dart';
import '../../theme/icons.dart';
import '../rating_widget.dart';
import 'favorite_btn_widget.dart';
import 'genres_list_widget.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              getIt<NavigationService>().navigate(MovieDetailsScreen(movie: movie,));
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedImageWidget(
                      imgUrl: "${ApiConstants.imageBaseUrl}${movie.posterPath}",
                      imgHeight: 170,
                      imgWidth: 100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            RatingWidget(voteAverage: movie.voteAverage.round()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GenresListWidget(genreIds: movie.genreIds,),
                        Row(
                          children: [
                            ReleaseDateWidget(releaseDate: movie.releaseDate),
                            Spacer(),
                            FavoriteBtnWidget(movie: movie,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(color: Colors.black12),
          )
        ],
      ),
    );
  }
}
