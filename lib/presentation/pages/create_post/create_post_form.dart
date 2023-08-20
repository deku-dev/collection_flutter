import 'package:flutter/material.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
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
                    decoration: const InputDecoration(labelText: 'Description'),
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
                  // Add more TextFormField widgets for inStock, year, etc.
                  DropdownButtonFormField<int>(
                    value: state.selectedTypeId,
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
                    decoration: const InputDecoration(labelText: 'Type'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a type';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    value: state.selectedCategoryId,
                    items: state.categories
                        .map((category) => DropdownMenuItem(
                              value: category.id,
                              child: Text(category.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      context
                          .read<CreatePostFormCubit>()
                          .updateSelectedCategory(value!);
                    },
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    value: state.selectedSeriesId,
                    items: state.series
                        .map((series) => DropdownMenuItem(
                              value: series.id,
                              child: Text(series.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      context
                          .read<CreatePostFormCubit>()
                          .updateSelectedSeries(value!);
                    },
                    decoration: const InputDecoration(labelText: 'Series'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a series';
                      }
                      return null;
                    },
                  ),
                  // Add similar dropdowns for categories and series

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
        );
      },
    );
  }
}
