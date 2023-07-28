import 'package:flutter/material.dart';
import '../components/post_card.dart';

class GridMain extends StatelessWidget {

  const GridMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Number of columns in the grid
      children: [
        PostCard(
          imageUrl: 'https://loremflickr.com/320/240',
          title: 'Post 1',
          onTap: () { debugPrint('Card tapped.'); },
        ),
        PostCard(
          imageUrl: 'https://loremflickr.com/320/240',
          title: 'Post 2',
          onTap: () { debugPrint('Card tapped.'); },
        ),
        // Add more PostCard widgets as needed
      ],
    );
  }
}