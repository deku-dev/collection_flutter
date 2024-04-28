import 'package:flutter/material.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/post_entity.dart';

class PostContent extends StatelessWidget {

  final PostEntity post;

  const PostContent({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                post.images!,
                // Replace with the actual image URL property of the Post model
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.0),
                      1: FlexColumnWidth(2.0),
                    },
                    children: [
                      TableRow(
                        children: [
                          const TableCell(
                            child: Text(
                              'Title:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(post.title),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const TableCell(
                            child: Text(
                              'Content:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(post.description!),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const TableCell(
                            child: Text(
                              'Category:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TableCell(
                            child: FutureBuilder<CategoryEntity?>(
                              future: post.getCategory(),
                              builder: (BuildContext context, AsyncSnapshot<CategoryEntity?> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  debugPrint(snapshot.error.toString());
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final category = snapshot.data!;
                                  return Text(category.name); // Replace `name` with the actual property of the Category model
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      // Add more rows as needed for other data in the Post entity
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}