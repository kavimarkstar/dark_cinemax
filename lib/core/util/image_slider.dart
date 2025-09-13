import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AutoImageSlider extends StatefulWidget {
  const AutoImageSlider({super.key});

  @override
  _AutoImageSliderState createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  final List<String> imageList = [
    "https://picsum.photos/800/400?img=1",
    "https://picsum.photos/800/400?img=2",
    "https://picsum.photos/800/400?img=3",
    "https://picsum.photos/800/400?img=4",
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: imageList.map((item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key
                    ? Colors.blue
                    : Colors.grey.shade400,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
