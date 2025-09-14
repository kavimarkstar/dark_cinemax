import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget movieLodingCardbuild(BuildContext context) {
  bool isdark = Theme.of(context).brightness == Brightness.dark;
  return InkWell(
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Animate(
                  onPlay: (controller) => controller.repeat(), // loop shimmer
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

          const SizedBox(height: 6),
          Animate(
            onPlay: (controller) => controller.repeat(), // loop shimmer
            effects: [ShimmerEffect(duration: 2000.ms)],
            child: Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isdark
                    ? const Color.fromARGB(255, 70, 70, 70)
                    : const Color.fromARGB(255, 231, 231, 231),
              ),
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 2),
          Animate(
            onPlay: (controller) => controller.repeat(), // loop shimmer
            effects: [ShimmerEffect(duration: 2000.ms)],
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isdark
                    ? const Color.fromARGB(255, 70, 70, 70)
                    : const Color.fromARGB(255, 231, 231, 231),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    ),
  );
}
