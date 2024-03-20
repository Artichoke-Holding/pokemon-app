import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildSkeletonScreen(BuildContext context) {
  // Assuming isLoading represents whether data is being loaded or not
  bool isLoading = true;

  return Skeletonizer(
    enabled: isLoading,
    child: ListView.builder(
      itemCount: 6, // Number of skeleton items to display
      itemBuilder: (context, index) {
        // Padding and Card mimic the structure of your content
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                // Simulate CarouselSlider skeleton
                if (index == 0)
                  Container(
                    height: 200, // Adjust to match your CarouselSlider's height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                // Simulate Details Sections skeleton
                if (index > 0)
                  ListTile(
                    leading: Container(width: 50, height: 50, color: Colors.grey),
                    title: Container(width: double.infinity, height: 10, color: Colors.grey),
                    subtitle: Container(width: 100, height: 10, color: Colors.grey),
                  ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
