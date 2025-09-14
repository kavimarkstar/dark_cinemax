import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_cinemax/core/widget/loding_card.dart';
import 'package:dark_cinemax/core/widget/movie_card.dart';
import 'package:flutter/material.dart';

class TvseriesPage extends StatefulWidget {
  const TvseriesPage({Key? key}) : super(key: key);

  @override
  _TvseriesPageState createState() => _TvseriesPageState();
}

class _TvseriesPageState extends State<TvseriesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TV Series")),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('tvseries')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
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
                final seriesList = snapshot.data!.docs;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.57,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: seriesList.length,
                  itemBuilder: (context, index) {
                    final series = seriesList[index];

                    return tvSeriesPCardbuild(context, series);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
