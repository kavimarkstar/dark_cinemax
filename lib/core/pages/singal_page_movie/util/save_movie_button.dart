import 'package:dark_cinemax/theme/Colors/appDarkColors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveMovieButton extends StatelessWidget {
  final String movieId;

  const SaveMovieButton({Key? key, required this.movieId}) : super(key: key);

  Future<void> _saveMovie(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in to save movies')),
        );
        return;
      }

      final docRef = FirebaseFirestore.instance
          .collection('savemovies')
          .doc(user.uid)
          .collection('userMovies')
          .doc(movieId);

      await docRef.set({
        'movieId': movieId,
        'userId': user.uid,
        'savedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Movie saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving movie: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _saveMovie(context),

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(width: 2, color: AppDarkColors.seed),
      ),
      child: Icon(Icons.bookmark_outline, color: AppDarkColors.seed),
    );
  }
}
