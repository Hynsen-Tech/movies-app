import 'package:flutter/material.dart';
import 'package:mvvm_state_management/models/movie_model.dart';
import 'package:mvvm_state_management/theme/icons.dart';
import '../widgets/movies/movies_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Movies'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(MyAppIcons.delete),
            color: Colors.red,
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Center();//MoviesWidget();
            }),
      ),
    );
  }
}