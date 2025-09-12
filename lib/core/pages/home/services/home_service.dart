import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_cinemax/core/pages/home/model/movie.dart';

class HomeService {
  HomeService._();
  static final HomeService instance = HomeService._();

  final CollectionReference<Map<String, dynamic>> _movies = FirebaseFirestore
      .instance
      .collection('movies')
      .withConverter(
        fromFirestore: (snap, _) => snap.data() ?? <String, dynamic>{},
        toFirestore: (data, _) => data,
      );

  Future<List<Movie>> fetchLatest({int limit = 10}) async {
    final query = await _movies
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return query.docs
        .map(
          (d) =>
              Movie.fromFirestore(d as DocumentSnapshot<Map<String, dynamic>>),
        )
        .toList();
  }

  Future<List<Movie>> fetchByCategory(String category, {int limit = 10}) async {
    final query = await _movies
        .where('categories', arrayContains: category)
        .limit(limit)
        .get();

    final movies = query.docs
        .map(
          (d) =>
              Movie.fromFirestore(d as DocumentSnapshot<Map<String, dynamic>>),
        )
        .toList();

    movies.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return movies;
  }
}
