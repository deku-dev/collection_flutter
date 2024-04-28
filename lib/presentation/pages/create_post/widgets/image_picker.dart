import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/pages/create_post/widgets/slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class MultipleImageField extends StatefulWidget {
  final Function(List<String>) onImagesSelected;
  final Function(String) onImagesDeleted;

  const MultipleImageField(
      {Key? key, required this.onImagesSelected, required this.onImagesDeleted})
      : super(key: key);

  @override
  State<MultipleImageField> createState() => _MultipleImageFieldState();
}

class _MultipleImageFieldState extends State<MultipleImageField> {
  List<String> _imagePaths = [];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Select Images'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _pickImages();
              },
            ),
          ],
        ),
        Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => _imagePaths.isNotEmpty,
            widgetBuilder: (BuildContext context) =>
                ImageSlider(imageUrls: _imagePaths, onImagesDeleted: imageDeleted),
            fallbackBuilder: (BuildContext context) => const Text(
                  'No images selected',
                  style: TextStyle(color: Colors.red),
                ))
      ],
    );
  }

  void imageDeleted(String path) {
    setState(() {
      _imagePaths.remove(path);
    });
    widget.onImagesDeleted(path);
  }

  void _pickImages() async {
    List<XFile>? imagePaths = await _picker.pickMultiImage(
      imageQuality: 50,
    );

    setState(() {
      _imagePaths += imagePaths.map((xFile) => xFile.path).toList();
    });

    widget.onImagesSelected(_imagePaths);
  }
}
