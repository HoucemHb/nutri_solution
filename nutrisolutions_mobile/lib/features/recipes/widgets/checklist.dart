import 'package:flutter/material.dart';

import 'ingredient_item.dart';

class ChecklistWidget extends StatefulWidget {
  final List<String> ingredients;

  const ChecklistWidget({Key? key, required this.ingredients}) : super(key: key);

  @override
  _ChecklistWidgetState createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  late List<bool> checkedStates;

  @override
  void initState() {
    super.initState();
    // Initially, nothing is checked
    checkedStates = List.generate(widget.ingredients.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.ingredients.length, (index) {
        return IngredientItem(
          ingredient: widget.ingredients[index],
          initiallyChecked: checkedStates[index],
          onChanged: (bool value) {
            setState(() {
              checkedStates[index] = value;
            });
          },
        );
      }),
    );
  }
}
