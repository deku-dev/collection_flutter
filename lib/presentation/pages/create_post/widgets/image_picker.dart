import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class MultipleImageField extends StatefulWidget {
  final List<String>? initialImages;
  final Function(List<String>) onImagesSelected;
  final Function(String) onImagesDeleted;

  const MultipleImageField({
    Key? key,
    this.initialImages,
    required this.onImagesSelected,
    required this.onImagesDeleted,
  }) : super(key: key);

  @override
  State<MultipleImageField> createState() => _MultipleImageFieldState();
}

class _MultipleImageFieldState extends State<MultipleImageField> {
  List<String> _imagePaths = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.initialImages != null) {
      _imagePaths = List.from(widget.initialImages!);
    }
  }

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
          widgetBuilder: (BuildContext context) => _buildImageGrid(),
          fallbackBuilder: (BuildContext context) => const Text(
            'No images selected',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _imagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(_imagePaths[index]),
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteImage(_imagePaths[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteImage(String path) {
    setState(() {
      _imagePaths.remove(path);
    });
    widget.onImagesDeleted(path);
  }

  Future<void> _pickImages() async {
    List<XFile>? pickedFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );

    List<String> savedPaths = await Future.wait(
      pickedFiles.map((xFile) => _saveImageToLocalStorage(xFile)).toList(),
    );

    setState(() {
      _imagePaths.addAll(savedPaths);
    });

    widget.onImagesSelected(_imagePaths);
    }

  Future<String> _saveImageToLocalStorage(XFile xFile) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appPath = appDir.path;
    final String fileName = path.basename(xFile.path);
    final String collectionDirPath = path.join(appPath, 'Collection');
    final String savedImagePath = path.join(collectionDirPath, fileName);
    try {
      // Ensure the directory exists
      await Directory(collectionDirPath).create(recursive: true);

      // Copy the file to the new location
      final File localImage = await File(xFile.path).copy(savedImagePath);
      return localImage.path;
    } catch (e) {
      // Handle any errors that occur during the file operations
      debugPrint('Error saving image to local storage: $e');
      return path.join(collectionDirPath, 'default_image.png');
    }
  }
}
