import 'package:dark_cinemax/core/pages/home/model/movie.dart';
import 'package:dark_cinemax/core/pages/home/services/home_service.dart';
import 'package:dark_cinemax/core/util/image_slider.dart';
import 'package:dark_cinemax/core/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DARK"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            AutoImageSlider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _Section(
                title: 'New Uploads',
                future: HomeService.instance.fetchLatest(limit: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _Section(
                title: 'Action',
                future: HomeService.instance.fetchByCategory(
                  'Action',
                  limit: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _Section(
                title: 'Action',
                future: HomeService.instance.fetchByCategory(
                  'Action',
                  limit: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Future<List<Movie>> future;
  final Axis scrollDirection;

  const _Section({
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
        SizedBox(
          height: 280,
          child: FutureBuilder<List<Movie>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final movies = snapshot.data ?? const <Movie>[];
              if (movies.isEmpty) {
                return const Center(child: Text('No movies found'));
              }
              return GridView.builder(
                scrollDirection: scrollDirection, // Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.7,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return movieCardbuild(context, movies[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
