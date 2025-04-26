import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';

class IngredientItem extends StatefulWidget {
  final String ingredient;
  final bool initiallyChecked;
  final ValueChanged<bool>? onChanged;

  const IngredientItem({
    Key? key,
    required this.ingredient,
    this.initiallyChecked = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _IngredientItemState createState() => _IngredientItemState();
}

class _IngredientItemState extends State<IngredientItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initiallyChecked;
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: const BorderSide(color: AppColors.hintText, width: 1.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            value: isChecked,
            activeColor: Colors.lightGreen,
            onChanged: _toggleCheckbox,
          ),
        ),
        const Gap(5),
        Text(
          widget.ingredient,
          style: TextStyle(
            fontSize: 16,
            decoration:
                isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            color: isChecked ? AppColors.hintText : AppColors.black,
          ),
        ),
      ],
    );
  }
}
