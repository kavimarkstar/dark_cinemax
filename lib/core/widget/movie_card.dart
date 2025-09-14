import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_cinemax/core/pages/Tv/page/signal_tv_series.dart';
import 'package:dark_cinemax/core/pages/home/model/movie.dart';
import 'package:dark_cinemax/core/pages/singal_page_movie/signal_page_movie.dart';
import 'package:dark_cinemax/core/pages/video_player/video_player_page.dart';
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

Widget tvSeriesPCardbuild(
  BuildContext context,
  QueryDocumentSnapshot<Object?> series,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TvSeriesDetailPage(
            seriesId: series.id,
            seriesName: series["name"],
            series: series,
          ),
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
              child:
                  series['imageBase64'] != null &&
                      (series['imageBase64'] ?? "").isNotEmpty
                  ? Image.memory(
                      base64Decode(series['imageBase64']),
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.tv, size: 50),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            series['name'] ?? 'Unnamed',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            series['name'] ?? 'Unnamed',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}

Widget episodePCardbuild(
  BuildContext context,
  QueryDocumentSnapshot<Object?> episodePCardbuild,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(
            videoUrl: episodePCardbuild["serverLink"],
            movieTitle: episodePCardbuild['imageBase64'],
          ),
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
              child:
                  episodePCardbuild['imageBase64'] != null &&
                      (episodePCardbuild['imageBase64'] ?? "").isNotEmpty
                  ? Image.memory(
                      base64Decode(episodePCardbuild['imageBase64']),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.play_circle_fill),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Episode ${episodePCardbuild['episodeNumber']}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
