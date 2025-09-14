import 'package:dark_cinemax/core/pages/home/services/home_service.dart';
import 'package:dark_cinemax/core/pages/search/search.dart';
import 'package:dark_cinemax/core/util/grid_view.dart';
import 'package:dark_cinemax/core/util/image_slider.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DARK"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            AutoImageSlider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Section(
                title: 'New Uploads',
                future: HomeService.instance.fetchLatest(limit: 12),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Section(
                title: 'Action',
                future: HomeService.instance.fetchByCategory(
                  'Action',
                  limit: 12,
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Section(
                title: 'Drama',
                future: HomeService.instance.fetchLatest(limit: 12),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
