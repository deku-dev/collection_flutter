import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/presentation/pages/create_post/widgets/image_picker.dart';
import 'package:flutter_app/presentation/pages/create_post/widgets/select_choice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_post_cubit.dart';
import 'create_post_state.dart';

class CreatePostFormPage extends StatelessWidget {
  const CreatePostFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostFormCubit(),
      child: const _CreatePostFormContent(),
    );
  }
}

class _CreatePostFormContent extends StatefulWidget {
  const _CreatePostFormContent();

  @override
  __CreatePostFormContentState createState() => __CreatePostFormContentState();
}

class __CreatePostFormContentState extends State<_CreatePostFormContent> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreatePostFormCubit>();
    cubit.updateTypes();
    cubit.updateCategories();
    cubit.updateSeries();
    cubit.updateCountries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostFormCubit, CreatePostFormState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
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
                      onImagesSelected: (imagePaths) {
                        context.read<CreatePostFormCubit>().updateImagePaths(imagePaths);
                      },
                      onImagesDeleted: (imagePath) {
                        context.read<CreatePostFormCubit>().deleteImagePath(imagePath);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.blueGrey),
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
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.blueGrey),
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
                      hintText: "Select a type",
                      showCustomItem: true,
                      searchHintText: "Search types...",
                      inputString: '',
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
                            context.read<CreatePostFormCubit>().submitForm();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Create Post', style: TextStyle(fontSize: 16.0)),
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
