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

  static final navKey = GlobalKey<NavigatorState>();

  const CustomSearchChoices({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.inputString,
    required this.onChanged,
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

  Future<T?> addItemDialog() async {
    return await showDialog<T>(
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
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final T itemId = (1 + widget.items.length) as T;
                      setState(() {
                        widget.items.add(DropdownMenuItem(
                          value: itemId,
                          child: Text(inputString!),
                        ));
                      });
                      Navigator.pop(alertContext, itemId);
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<T>> dropdownItems = widget.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchChoices.single(
          items: dropdownItems,
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
          disabledHint: (Function updateParent) {
            return TextButton(
              onPressed: () {
                addItemDialog().then((value) {
                  if (value != null) {
                    updateParent(value);
                  }
                });
              },
              child: const Text("No choice, click to add one"),
            );
          },
          emptyListWidget: (String? keyword, BuildContext closeContext, Function updateParent) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    addItemDialog().then((value) {
                      if (value != null) {
                        updateParent(value);
                      }
                    });
                  },
                  child: const Text("No choice, click to add one"),
                ),
              ),
            );
          },
          closeButton: (T? value, BuildContext closeContext, Function updateParent) {
            return dropdownItems.length >= 100
                ? "Close"
                : TextButton(
              onPressed: () {
                addItemDialog().then((value) {
                  if (value != null && dropdownItems.indexWhere((element) => element.value == value) == -1) {
                    updateParent(value);
                  }
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
