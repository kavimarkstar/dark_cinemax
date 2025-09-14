import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_cinemax/core/widget/movie_card.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final String seriesId;
  final QueryDocumentSnapshot<Object?> series; // Firestore document
  final String seriesName;

  const TvSeriesDetailPage({
    Key? key,
    required this.seriesId,
    required this.seriesName,
    required this.series,
  }) : super(key: key);

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.seriesName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster + Overlay
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.white.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child:
                        widget.series['imageBase64'] != null &&
                            (widget.series['imageBase64'] ?? "").isNotEmpty
                        ? Image.memory(
                            base64Decode(widget.series['imageBase64']),
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.tv, size: 50),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),

                            isDark
                                ? Colors.black.withOpacity(0.7)
                                : Colors.white.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ), // Bottom Shadow Gradient
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            isDark
                                ? Colors.black.withOpacity(0.8)
                                : Colors.white.withOpacity(1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.series['name'] ?? 'Unknown Series',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.series['description'] ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Year: ${widget.series['year'] ?? 'N/A'} • Genre: ${widget.series['genre'] ?? 'N/A'}',
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        Text(
                          'Country: ${widget.series['country'] ?? 'N/A'} • Creator: ${widget.series['creator'] ?? 'N/A'}',
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Seasons + Episodes
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('tvseries')
                  .doc(widget.seriesId)
                  .collection('seasons')
                  .orderBy('seasonNumber')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final seasons = snapshot.data!.docs;

                return Column(
                  children: seasons.map((seasonSnapshot) {
                    final seasonData =
                        seasonSnapshot.data() as Map<String, dynamic>;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Season ${seasonData['seasonNumber']}",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection('tvseries')
                                .doc(widget.seriesId)
                                .collection('seasons')
                                .doc(seasonSnapshot.id)
                                .collection('episodes')
                                .orderBy('episodeNumber')
                                .snapshots(),
                            builder: (context, episodeSnapshot) {
                              if (episodeSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (episodeSnapshot.hasError) {
                                return Text('Error: ${episodeSnapshot.error}');
                              }

                              final episodes = episodeSnapshot.data!.docs;

                              return SizedBox(
                                height: 250, // height of horizontal grid
                                child: GridView.builder(
                                  scrollDirection:
                                      Axis.horizontal, // scroll left-right
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, // 1 row
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio:
                                            1.65, // adjust card width/height ratio
                                      ),
                                  itemCount: episodes.length,
                                  itemBuilder: (context, index) {
                                    final episode = episodes[index];
                                    return episodePCardbuild(
                                      context,
                                      episode,
                                    ); // your episode card widget
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
