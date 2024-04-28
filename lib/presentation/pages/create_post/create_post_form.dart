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
      child: _CreatePostFormContent(),
    );
  }
}

class _CreatePostFormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostFormCubit, CreatePostFormState>(
      builder: (context, state) {
        context.read<CreatePostFormCubit>().updateTypes();
        context.read<CreatePostFormCubit>().updateCategories();
        context.read<CreatePostFormCubit>().updateSeries();
        context.read<CreatePostFormCubit>().updateCountries();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MultipleImageField(
                      onImagesSelected: (imagePaths) {
                        context
                            .read<CreatePostFormCubit>()
                            .updateImagePaths(imagePaths);
                      },
                      onImagesDeleted: (imagePath) {
                        context
                            .read<CreatePostFormCubit>()
                            .deleteImagePath(imagePath);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Title'),
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
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      onChanged: (description) {
                        context
                            .read<CreatePostFormCubit>()
                            .updateDescription(description);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Enter a Year (YYYY)'),
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (year) {
                        context
                            .read<CreatePostFormCubit>()
                            .updateYear(int.parse(year));
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a year';
                        }
                        return null;
                      },
                    ),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedTypeId,
                      items: state.types
                          .map((type) => DropdownMenuItem<int>(
                                value: type.id!,
                                child: Text(type.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context
                            .read<CreatePostFormCubit>()
                            .updateSelectedType(value!);
                      },
                      hintText: "Select an type",
                      showCustomItem: true,
                      searchHintText: "Search types...",
                      inputString: '',
                    ),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedCategoryId,
                      items: state.categories
                          .map((category) => DropdownMenuItem<int>(
                                value: category.id!,
                                child: Text(category.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context
                            .read<CreatePostFormCubit>()
                            .updateSelectedCategory(value!);
                      },
                      hintText: "Select an category",
                      showCustomItem: true,
                      searchHintText: "Search categories...",
                      inputString: '',
                    ),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedSeriesId,
                      items: state.series
                          .map((series) => DropdownMenuItem<int>(
                                value: series.id!,
                                child: Text(series.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context
                            .read<CreatePostFormCubit>()
                            .updateSelectedSeries(value!);
                      },
                      hintText: "Select an series",
                      showCustomItem: true,
                      searchHintText: "Search series...",
                      inputString: '',
                    ),
                    CustomSearchChoices<int>(
                      selectedValue: state.selectedCountryId,
                      items: state.countries
                          .map((country) => DropdownMenuItem<int>(
                                value: country.id!,
                                child: Text(country.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context
                            .read<CreatePostFormCubit>()
                            .updateSelectedCountry(value!);
                      },
                      hintText: "Select an country",
                      showCustomItem: true,
                      searchHintText: "Search countries...",
                      inputString: '',
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              semanticLabel: 'In Stock',
                              value: state.inStock,
                              onChanged: (value) {
                                context
                                    .read<CreatePostFormCubit>()
                                    .updateInStock(value!);
                              }),
                          const Text('In Stock'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CreatePostFormCubit>().submitForm();
                      },
                      child: const Text('Create Post'),
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
