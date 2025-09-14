import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dark_cinemax/theme/Colors/appDarkColors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AutoImageSlider extends StatefulWidget {
  const AutoImageSlider({super.key});

  @override
  _AutoImageSliderState createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('banner')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                  height: 190,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(
                      child: Animate(
                        onPlay: (controller) =>
                            controller.repeat(), // loop shimmer
                        effects: [ShimmerEffect(duration: 2000.ms)],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isdark
                                ? const Color.fromARGB(255, 70, 70, 70)
                                : const Color.fromARGB(255, 231, 231, 231),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: Animate(
                        onPlay: (controller) =>
                            controller.repeat(), // loop shimmer
                        effects: [ShimmerEffect(duration: 2000.ms)],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isdark
                                ? const Color.fromARGB(255, 70, 70, 70)
                                : const Color.fromARGB(255, 231, 231, 231),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: Animate(
                        onPlay: (controller) =>
                            controller.repeat(), // loop shimmer
                        effects: [ShimmerEffect(duration: 2000.ms)],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isdark
                                ? const Color.fromARGB(255, 70, 70, 70)
                                : const Color.fromARGB(255, 231, 231, 231),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: Animate(
                        onPlay: (controller) =>
                            controller.repeat(), // loop shimmer
                        effects: [ShimmerEffect(duration: 2000.ms)],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isdark
                                ? const Color.fromARGB(255, 70, 70, 70)
                                : const Color.fromARGB(255, 231, 231, 231),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        final docs = snapshot.data!.docs;

        // Convert Firestore Base64 images to Uint8List
        final List<Uint8List> imageBytesList = docs.map((doc) {
          String base64Image = doc['image'];
          return base64Decode(base64Image);
        }).toList();

        if (imageBytesList.isEmpty) {
          return Center(child: Text("No banners found."));
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 190,
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
              items: imageBytesList.map((imageBytes) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    imageBytes,
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
              children: imageBytesList.asMap().entries.map((entry) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? AppDarkColors.seed
                        : Colors.grey.shade400,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
