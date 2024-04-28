import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls; // Replace with your image URLs
  final Function(String) onImagesDeleted;

  const ImageSlider({super.key, required this.imageUrls, required this.onImagesDeleted});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageUrls.map((path) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.file(
                    File(path),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0, // Adjust the top value for vertical positioning
                  right: 0, // Adjust the right value for horizontal positioning
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Handle delete action here, e.g., by removing the image URL from the list
                      debugPrint('Delete image $path');
                      onImagesDeleted(path);
                    },
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 200.0, // Adjust the height as needed
        autoPlay: false,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
    );
  }

}