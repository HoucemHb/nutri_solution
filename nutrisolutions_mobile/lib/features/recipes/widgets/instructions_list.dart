import 'package:flutter/material.dart';
import 'instruction_item.dart'; // Import your InstructionItem

class InstructionsList extends StatefulWidget {
  final List<String> instructions;

  const InstructionsList({
    super.key,
    required this.instructions,
  });

  @override
  State<InstructionsList> createState() => _InstructionsListState();
}

class _InstructionsListState extends State<InstructionsList> {
  late List<bool> _checked;

  @override
  void initState() {
    super.initState();
    _checked = List<bool>.filled(widget.instructions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.instructions.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InstructionItem(
            number: index + 1,
            instruction: widget.instructions[index],
            initiallyChecked: _checked[index],
            onChanged: (value) {
              setState(() {
                _checked[index] = value;
              });
            },
          ),
        );
      }),
    );
  }
}
