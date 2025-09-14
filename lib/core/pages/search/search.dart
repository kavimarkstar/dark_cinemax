import 'package:dark_cinemax/core/pages/home/model/movie.dart';
import 'package:dark_cinemax/core/pages/search/view/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  Stream<List<String>> _fetchTitles(String query) {
    final collection = FirebaseFirestore.instance.collection('movies');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Movie.fromFirestore(doc).title)
          .where((title) => title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 16,
              ),
              hintText: 'Search movies...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onChanged: (_) {
              setState(() {}); // refresh suggestions
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: _fetchTitles(_searchController.text),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final titles = snapshot.data!;
                if (titles.isEmpty) {
                  return const Center(child: Text('No titles found'));
                }
                return ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    final title = titles[index];
                    return ListTile(
                      title: Text(title),
                      onTap: () {
                        // Navigate to results page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SearchResultPage(searchTitle: title),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
