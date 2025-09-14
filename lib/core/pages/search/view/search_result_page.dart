import 'package:dark_cinemax/core/pages/home/model/movie.dart';
import 'package:dark_cinemax/core/widget/loding_card.dart';
import 'package:dark_cinemax/core/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchResultPage extends StatelessWidget {
  final String searchTitle;

  const SearchResultPage({Key? key, required this.searchTitle})
    : super(key: key);

  Stream<List<Movie>> _fetchMoviesByTitle(String title) {
    final collection = FirebaseFirestore.instance.collection('movies');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Movie.fromFirestore(doc))
          .where(
            (movie) => movie.title.toLowerCase().contains(title.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Text(searchTitle, style: TextStyle(fontSize: 15)),
              ),
              StreamBuilder<List<Movie>>(
                stream: _fetchMoviesByTitle(searchTitle),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
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
                  final movies = snapshot.data!;
                  if (movies.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
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
          ),
        ),
      ),
    );
  }
}
