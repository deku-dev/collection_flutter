import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class CustomSearchChoices<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final String? inputString;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String? hintText;
  final String? searchHintText;
  final bool showCustomItem;
  final void Function(String) addItem;

  static final navKey = GlobalKey<NavigatorState>();

  const CustomSearchChoices({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.inputString,
    required this.onChanged,
    required this.addItem,
    this.hintText,
    this.searchHintText,
    this.showCustomItem = true,
  });

  @override
  _CustomSearchChoicesState<T> createState() => _CustomSearchChoicesState<T>();
}

class _CustomSearchChoicesState<T> extends State<CustomSearchChoices<T>> {
  T? _selectedValue;
  String? inputString;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
    inputString = widget.inputString;
  }

  Future<void> addItemDialog() async {
    final result = await showDialog<String>(
      context: CustomSearchChoices.navKey.currentState?.overlay?.context ?? context,
      builder: (BuildContext alertContext) {
        return AlertDialog(
          title: const Text("Add an item"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    return (value == null || value.isEmpty) ? "must not be empty" : null;
                  },
                  initialValue: inputString,
                  onChanged: (value) {
                    inputString = value;
                  },
                  autofocus: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.pop(alertContext, inputString);
                        }
                      },
                      child: const Text("Ok"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(alertContext, null);
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result != null) {
      widget.addItem(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<T>> dropdownItems = widget.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchChoices.single(
          items: dropdownItems.isEmpty ? [const DropdownMenuItem<int>(
            value: null,
            child: Text('Empty Placeholder'),
          )] : dropdownItems,
          value: _selectedValue,
          padding: 2,
          hint: widget.hintText != null ? Text(widget.hintText!) : null,
          searchHint: widget.searchHintText != null ? Text(widget.searchHintText!) : null,
          isExpanded: true,
          searchFn: (String keyword, items) {
            if (keyword.isEmpty) {
              return Iterable<int>.generate(items.length).toList();
            }
            List<int> ret = [];
            if (keyword.isNotEmpty) {
              for (var item in items) {
                if (item.child
                    .toString()
                    .toLowerCase()
                    .contains(keyword.toLowerCase())) {
                  ret.add(items.indexOf(item));
                }
              }
            }
            return (ret);
          },
          disabledHint: (Function updateParent, {dynamic param}) {
            return TextButton(
              onPressed: () {
                addItemDialog().then((_) {
                  updateParent(param);
                });
              },
              child: const Text("No choice, click to add one"),
            );
          },
          emptyListWidget: (String? keyword, BuildContext closeContext, Function updateParent, {dynamic param}) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    addItemDialog().then((_) {
                      updateParent(param);
                    });
                  },
                  child: const Text("No choice, click to add one1"),
                ),
              ),
            );
          },
          closeButton: (T? value, BuildContext closeContext, Function updateParent, {dynamic param}) {
            return dropdownItems.length >= 100
                ? "Close"
                : TextButton(
              onPressed: () {
                addItemDialog().then((_) {
                  updateParent(param);
                });
              },
              child: const Text("Add and select item"),
            );
          },
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
