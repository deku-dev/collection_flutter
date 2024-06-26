import 'package:Collectioneer/presentation/pages/create_post/widgets/image_picker.dart';
import 'package:Collectioneer/presentation/pages/create_post/widgets/select_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../data/database/database.dart';
import '../../../domain/entities/post_entity.dart';
import 'create_post_cubit.dart';
import 'create_post_state.dart';

class CreatePostFormPage extends StatelessWidget {

  CreatePostFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? postId;
    if (QR.params.isNotEmpty) {
      postId = QR.params['id']!.asInt!;
    }

    if (QR.params.isNotEmpty && postId != null) {
      return FutureBuilder<PostEntity?>(
        future: GetIt.instance<AppDatabase>().postDao.findPostById(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Loading Post...'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text('Error loading post: ${snapshot.error}'),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Post Not Found'),
              ),
              body: Center(
                child: Text('Post with ID $postId not found.'),
              ),
            );
          } else {
            // Post found, pass it to BlocProvider and render form content
            return BlocProvider(
              create: (context) => CreatePostFormCubit(snapshot.data!),
              child: _CreatePostFormContent(),
            );
          }
        },
      );
    } else {
      return BlocProvider(
        create: (context) => CreatePostFormCubit(null),
        child: _CreatePostFormContent(),
      );
    }

  }
}

class _CreatePostFormContent extends StatefulWidget {
  _CreatePostFormContent();

  @override
  __CreatePostFormContentState createState() => __CreatePostFormContentState();
}

class __CreatePostFormContentState extends State<_CreatePostFormContent> {
  final _formKey = GlobalKey<FormState>();
  late Future<PostEntity?> post;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreatePostFormCubit>();
    cubit.updateTypes();
    cubit.updateCategories();
    cubit.updateSeries();
    cubit.updateCountries();


    if (cubit.state.post != null) {
      cubit.loadPostData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostFormCubit, CreatePostFormState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.post == null ? 'Create Post' : 'Edit Post'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MultipleImageField(
                      initialImages: state.imageUrls,
                      onImagesSelected: (imagePaths) {
                        context.read<CreatePostFormCubit>().updateImagePaths(imagePaths);
                      },
                      onImagesDeleted: (imagePath) {
                        context.read<CreatePostFormCubit>().deleteImagePath(imagePath);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: state.title,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: const TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (title) {
                        context.read<CreatePostFormCubit>().updateTitle(title);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: state.description,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: const TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      maxLines: 3,
                      onChanged: (description) {
                        context.read<CreatePostFormCubit>().updateDescription(description);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: state.year?.toString(),
                      decoration: InputDecoration(
                        labelText: 'Enter a Year (YYYY)',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (year) {
                        if (year.isNotEmpty) {
                          context.read<CreatePostFormCubit>().updateYear(int.parse(year));
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a year';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedTypeId,
                      items: state.types.map((type) => DropdownMenuItem<int>(
                        value: type.id!,
                        child: Text(type.name),
                      )).toList(),
                      onChanged: (value) {
                        context.read<CreatePostFormCubit>().updateSelectedType(value!);
                      },
                      hintText: "Select a author",
                      showCustomItem: true,
                      searchHintText: "Search authors...",
                      inputString: '',
                      addItem: (String name) async {
                        await context.read<CreatePostFormCubit>().addType(name);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedCategoryId,
                      items: state.categories.map((category) => DropdownMenuItem<int>(
                        value: category.id!,
                        child: Text(category.name),
                      )).toList(),
                      onChanged: (value) {
                        context.read<CreatePostFormCubit>().updateSelectedCategory(value!);
                      },
                      hintText: "Select a category",
                      showCustomItem: true,
                      searchHintText: "Search categories...",
                      inputString: '',
                      addItem: (String name) async {
                        await context.read<CreatePostFormCubit>().addCategory(name);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedSeriesId,
                      items: state.series.map((series) => DropdownMenuItem<int>(
                        value: series.id!,
                        child: Text(series.name),
                      )).toList(),
                      onChanged: (value) {
                        context.read<CreatePostFormCubit>().updateSelectedSeries(value!);
                      },
                      hintText: "Select a series",
                      showCustomItem: true,
                      searchHintText: "Search series...",
                      inputString: '',
                      addItem: (String name) async {
                        await context.read<CreatePostFormCubit>().addSeries(name);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedCountryId,
                      items: state.countries.map((country) => DropdownMenuItem<int>(
                        value: country.id!,
                        child: Text(country.name),
                      )).toList(),
                      onChanged: (value) {
                        context.read<CreatePostFormCubit>().updateSelectedCountry(value!);
                      },
                      hintText: "Select a country",
                      showCustomItem: true,
                      searchHintText: "Search countries...",
                      inputString: '',
                      addItem: (String name) {
                        context.read<CreatePostFormCubit>().addCountry(name);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          semanticLabel: 'In Stock',
                          value: state.inStock,
                          onChanged: (value) {
                            context.read<CreatePostFormCubit>().updateInStock(value!);
                          },
                        ),
                        const Text('In Stock', style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<CreatePostFormCubit>().submitForm(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Submit', style: TextStyle(fontSize: 16.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
