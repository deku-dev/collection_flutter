import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class CustomSearchChoices<int> extends StatefulWidget {
  final List<DropdownMenuItem<int>> items;
  final String? inputString;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;
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
  _CustomSearchChoicesState<int> createState() =>
      _CustomSearchChoicesState<int>();
}

class _CustomSearchChoicesState<int> extends State<CustomSearchChoices<int>> {
  int? _selectedValue;
  String? inputString;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
    inputString = widget.inputString;
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> dropdownItems = widget.items;

    final input = TextFormField(
      validator: (value) {
        return ((value?.length ?? 0) < 6
            ? "must be at least 6 characters long"
            : null);
      },
      initialValue: inputString,
      onChanged: (value) {
        inputString = value;
      },
      autofocus: true,
    );

    addItemDialog() async {
      return await showDialog(
        context: CustomSearchChoices.navKey.currentState?.overlay?.context ?? context,
        builder: (BuildContext alertContext) {
          Widget dialogWidget = AlertDialog(
            title: const Text("Add an item"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  input,
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final int? itemId = 1 + dropdownItems.length as int?;
                        setState(() {
                          dropdownItems.add(DropdownMenuItem(
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
          return dialogWidget;
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchChoices.single(
          items: dropdownItems,
          value: _selectedValue,
          padding: 2,
          hint: widget.hintText != null ? Text(widget.hintText!) : null,
          searchHint: widget.searchHintText != null
              ? Text(widget.searchHintText!)
              : null,
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
            return (TextButton(
              onPressed: () {
                addItemDialog().then((value) async {
                  updateParent(value);
                });
              },
              child: const Text("No choice, click to add one"),
            ));
          },
          emptyListWidget: (String? keyword, BuildContext closeContext,
              Function updateParent) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    addItemDialog().then((value) async {

                      debugPrint("value: 1");
                      // _selectedValue = value;
                    });
                  },
                  child: const Text("No choice, click to add one"),
                ),
              ),
            );
          },
          closeButton:
              (int? value, BuildContext closeContext, Function updateParent) {
            return (dropdownItems.length >= 100
                ? "Close"
                : TextButton(
                    onPressed: () {
                      debugPrint("value: $value");
                      addItemDialog().then((value) async {
                        if (value != null &&
                            dropdownItems.indexWhere(
                                    (element) => element.value == value) !=
                                -1) {
                          Navigator.pop(context);
                          updateParent(value);
                        }
                      });
                    },
                    child: const Text("Add and select item"),
                  ));
          },
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onChanged(value);
          },
          // displayItem: (item, isSelected) {
          //   // Customize how items are displayed here
          //   return isSelected ? const SizedBox.shrink() : item;
          // },
        ),
      ],
    );
  }
}
