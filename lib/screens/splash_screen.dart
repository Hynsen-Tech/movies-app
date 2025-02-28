import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_state_management/repository/movie_repository.dart';
import 'package:mvvm_state_management/screens/movies_screen.dart';
import 'package:mvvm_state_management/services/init_getit.dart';
import 'package:mvvm_state_management/services/navigation_service.dart';
import 'package:mvvm_state_management/view_models/movies/movies_bloc.dart';
import 'package:mvvm_state_management/widgets/error_widget.dart';

import '../utils/genre_util.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = getIt<MoviesBloc>();

    return Scaffold(
      body: BlocConsumer<MoviesBloc, MoviesState>(listener: (context, state) {
        if (state is MoviesLoadedState) {
          getIt<NavigationService>().navigateReplacing(const MoviesScreen());
        }
      }, builder: (context, state) {
        final currentState = state;
        switch (currentState) {
          case MoviesInitialState() || MoviesIsLoadingState():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loading...'),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator.adaptive(),
                ],
              ),
            );
          case MoviesLoadedState():
            return SizedBox.shrink();
          case MoviesErrorState():
            return MyErrorWidget(
              errorText: currentState.errorMessage,
              retryFunction: () {
                moviesBloc.add(FetchMoviesEvent());
              },
            );
          default:
            return MyErrorWidget(
              errorText: "Error",
              retryFunction: () {
                moviesBloc.add(FetchMoviesEvent());
              },
            );
        }
      }),
    );
  }
}
