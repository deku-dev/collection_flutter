import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../domain/entities/post_entity.dart';
import '../../widgets/image_fallback.dart';

class PostContent extends StatelessWidget {
  final PostEntity post;

  const PostContent({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TappableImage(imageUrl: post.firstImage),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                post.description ?? 'No description',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              FutureDataWidget(
                future: post.getCategory(),
                builder: (data) => Text(
                  'Category: ${data?.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                loadingWidget: const CircularProgressIndicator(),
                errorWidget: (error) => Text('Error: $error'),
                emptyWidget: const Text('No category found'),
              ),
              FutureDataWidget(
                future: post.getSeries(),
                builder: (data) => Text(
                  'Series: ${data?.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                loadingWidget: const CircularProgressIndicator(),
                errorWidget: (error) => Text('Error: $error'),
                emptyWidget: const Text('No series found'),
              ),
              FutureDataWidget(
                future: post.getType(),
                builder: (data) => Text(
                  'Type: ${data?.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                loadingWidget: const CircularProgressIndicator(),
                errorWidget: (error) => Text('Error: $error'),
                emptyWidget: const Text('No type found'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TappableImage extends StatelessWidget {
  final String imageUrl;

  const TappableImage({Key? key, required this.imageUrl}) : super(key: key);

  void _openImageGallery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageGallery(images: [imageUrl]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openImageGallery(context),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          SizedBox(
            height: 250.0,
            width: double.infinity,
            child: NetworkImageWithFallback(
              imageUrl: imageUrl,
              fit: BoxFit.fitHeight,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.photo_album),
            onPressed: () => _openImageGallery(context),
          ),
        ],
      ),
    );
  }
}

class FutureDataWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) builder;
  final Widget loadingWidget;
  final Widget Function(dynamic error)? errorWidget;
  final Widget emptyWidget;

  const FutureDataWidget({
    Key? key,
    required this.future,
    required this.builder,
    required this.loadingWidget,
    this.errorWidget,
    required this.emptyWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget;
        } else if (snapshot.hasError) {
          return errorWidget != null
              ? errorWidget!(snapshot.error)
              : Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return emptyWidget;
        } else {
          return builder(snapshot.data!);
        }
      },
    );
  }
}

class ImageGallery extends StatelessWidget {
  final List<String> images;

  const ImageGallery({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: index),
          );
        },
        itemCount: images.length,
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded /
                  (event.expectedTotalBytes ?? 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
