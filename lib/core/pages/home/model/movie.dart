import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String id;
  final String title;
  final String description;
  final int year;
  final int runtime;
  final String director;
  final String country;
  final List<String> categories;
  final List<String> tags;
  final String serverLink;
  final String posterBase64;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    required this.runtime,
    required this.director,
    required this.country,
    required this.categories,
    required this.tags,
    required this.serverLink,
    required this.posterBase64,
    required this.createdAt,
    required this.updatedAt,
  });

  Uint8List? get posterBytes {
    try {
      return base64Decode(posterBase64);
    } catch (_) {
      return null;
    }
  }

  factory Movie.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Movie(
      id: doc.id,
      title: (data['title'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      year: (data['year'] is int)
          ? data['year'] as int
          : int.tryParse('${data['year']}') ?? 0,
      runtime: (data['runtime'] is int)
          ? data['runtime'] as int
          : int.tryParse('${data['runtime']}') ?? 0,
      director: (data['director'] ?? '').toString(),
      country: (data['country'] ?? '').toString(),
      categories:
          (data['categories'] as List?)?.map((e) => '$e').toList() ?? const [],
      tags: (data['tags'] as List?)?.map((e) => '$e').toList() ?? const [],
      serverLink: (data['serverLink'] ?? '').toString(),
      posterBase64: (data['posterBase64'] ?? '').toString(),
      createdAt: _toDateTime(data['createdAt']),
      updatedAt: _toDateTime(data['updatedAt']),
    );
  }

  static DateTime _toDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}
