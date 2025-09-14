import 'package:dark_cinemax/core/pages/home/services/home_service.dart';
import 'package:dark_cinemax/core/pages/search/search.dart';
import 'package:dark_cinemax/core/util/grid_view.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Section(
            title: 'New And Trending ',
            future: HomeService.instance.fetchLatest(limit: 12),
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }
}
