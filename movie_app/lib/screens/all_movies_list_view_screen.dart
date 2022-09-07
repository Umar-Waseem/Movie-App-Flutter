import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../providers/all_movies_provider.dart';
import '../providers/favorite_movie_provider.dart';
import 'movies_page_view_screen.dart';

class AllMoviesListViewScreen extends StatelessWidget {
  const AllMoviesListViewScreen({
    Key? key,
    required this.allMoviesData,
    required this.favMoviesData,
  }) : super(key: key);

  final AllMoviesProvider allMoviesData;
  final FavoriteMovieProvider favMoviesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Movies'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        itemCount: allMoviesData.allMoviePagesList.length,
        itemBuilder: (context, index) {
          Movie currentMovie = allMoviesData.allMovies[index];
          return ListTile(
            leading: Hero(
              tag: index,
              child: Image.asset(
                currentMovie.image,
                height: 100,
                width: 100,
              ),
            ),
            title: Text(
              currentMovie.title,
            ),
            subtitle: Text(
              currentMovie.description,
            ),
            trailing: IconButton(
              onPressed: () {
                favMoviesData.toggleFavorite(currentMovie);
              },
              icon: Icon(
                currentMovie.isFav
                    ? Icons.favorite_outlined
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MoviePageViewScreen(
                    initalIndex: index,
                    children: allMoviesData.allMoviePagesList,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
