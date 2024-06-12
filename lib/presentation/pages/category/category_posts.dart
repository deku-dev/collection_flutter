import 'package:flutter/material.dart';

import '../../../domain/entities/post_entity.dart';
import '../../routes.dart';
import '../../widgets/teasers_widget.dart';


class CategoryPostsWidget extends StatelessWidget {
  final List<PostEntity> teaserPosts;

  const CategoryPostsWidget({Key? key, required this.teaserPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TeasersWidget<PostEntity>(
      items: teaserPosts,
      imageUrlBuilder: (post) => post.firstImage, // Assuming CategoryEntity has imageUrl
      titleBuilder: (post) => post.title,
      idBuilder: (post) => post.id,
      routeName: AppRoutes.postPage,
    );
  }
}