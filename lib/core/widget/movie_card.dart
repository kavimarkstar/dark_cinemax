import 'dart:typed_data';

import 'package:dark_cinemax/core/pages/home/model/movie.dart';
import 'package:dark_cinemax/core/pages/singal_page_movie/signal_page_movie.dart';
import 'package:flutter/material.dart';

Widget movieCardbuild(BuildContext context, Movie movie) {
  final Uint8List? bytes = movie.posterBytes;
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignalPageMovieView(movie: movie),
        ),
      );
    },
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: bytes != null
                  ? Image.memory(bytes, fit: BoxFit.cover)
                  : Container(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported_outlined),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            "${movie.year} • ${movie.categories.isNotEmpty ? movie.categories.first : ''}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}
