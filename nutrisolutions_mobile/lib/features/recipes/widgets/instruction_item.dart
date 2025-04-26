import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class InstructionItem extends StatefulWidget {
  final int number;
  final String instruction;
  final bool initiallyChecked;
  final ValueChanged<bool>? onChanged; // <-- add this

  const InstructionItem({
    Key? key,
    required this.number,
    required this.instruction,
    this.initiallyChecked = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _InstructionItemState createState() => _InstructionItemState();
}

class _InstructionItemState extends State<InstructionItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initiallyChecked;
  }

  void toggleChecked() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChanged?.call(isChecked); // <-- notify parent
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleChecked,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.secondaryColor : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.transparent),
            ),
            alignment: Alignment.center,
            child: Text(
              '${widget.number}',
              style: TextStyle(
                color: isChecked ? Colors.white : AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.instruction,
              style: TextStyle(
                fontSize: 16,
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: isChecked ? AppColors.hintText : AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
