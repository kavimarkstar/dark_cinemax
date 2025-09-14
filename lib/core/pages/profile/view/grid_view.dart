import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_cinemax/core/pages/home/model/movie.dart';
import 'package:dark_cinemax/core/widget/loding_card.dart';
import 'package:dark_cinemax/core/widget/movie_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedMoviesGrid extends StatelessWidget {
  const SavedMoviesGrid({Key? key}) : super(key: key);

  // Function to unsave a movie
  Future<void> unsaveMovie(String movieId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('savemovies')
        .doc(user.uid)
        .collection('userMovies')
        .doc(movieId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text("You must be logged in to view saved movies"),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('savemovies')
          .doc(user.uid)
          .collection('userMovies')
          .orderBy('savedAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No saved movies found"));
        }

        final movieIds = snapshot.data!.docs.map((doc) => doc.id).toList();

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('movies')
              .where(FieldPath.documentId, whereIn: movieIds)
              .snapshots(),
          builder: (context, movieSnapshot) {
            if (movieSnapshot.connectionState == ConnectionState.waiting) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
            if (!movieSnapshot.hasData || movieSnapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No saved movies found"));
            }

            final movies = movieSnapshot.data!.docs
                .map(
                  (doc) => Movie.fromFirestore(
                    doc as DocumentSnapshot<Map<String, dynamic>>,
                  ),
                )
                .toList();

            return gridViewbuild(context, movies, unsaveMovie);
          },
        );
      },
    );
  }
}

Widget gridViewbuild(
  BuildContext context,
  List<Movie> movies,
  Function(String) unsaveMovie,
) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.57,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) {
      return Stack(
        children: [
          movieCardbuild(context, movies[index]),
          Positioned(
            top: 15,
            right: 15,
            child: GestureDetector(
              onTap: () => unsaveMovie(movies[index].id),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
