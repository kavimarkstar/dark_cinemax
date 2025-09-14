import 'package:dark_cinemax/core/pages/home/model/movie.dart';
import 'package:dark_cinemax/core/widget/loding_card.dart';
import 'package:dark_cinemax/core/widget/movie_card.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final Future<List<Movie>> future;
  final Axis scrollDirection;

  const Section({
    super.key,
    required this.title,
    required this.future,
    this.scrollDirection = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        scrollDirection == Axis.horizontal
            ? SizedBox(
                height: 275,
                child: FutureBuilder<List<Movie>>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 160,
                            child: movieLodingCardbuild(context),
                          );
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final movies = snapshot.data ?? const <Movie>[];
                    if (movies.isEmpty) {
                      return const Center(child: Text('No movies found'));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 160,
                          child: movieCardbuild(context, movies[index]),
                        );
                      },
                    );
                  },
                ),
              )
            : FutureBuilder<List<Movie>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.57,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return movieLodingCardbuild(context);
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final movies = snapshot.data ?? const <Movie>[];
                  if (movies.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.57,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return movieCardbuild(context, movies[index]);
                    },
                  );
                },
              ),
      ],
    );
  }
}
