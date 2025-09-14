import 'package:dark_cinemax/core/pages/home/home.dart';
import 'package:dark_cinemax/core/pages/profile/profile.dart';
import 'package:dark_cinemax/core/pages/trending/trending.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomePage(),
    TrendingPage(),
    const Center(child: Text('NOTIFI')),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        showUnselectedLabels: false,
        showSelectedLabels: true,
      ),
    );
  }
}
