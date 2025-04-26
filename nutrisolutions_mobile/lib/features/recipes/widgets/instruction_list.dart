import 'package:flutter/material.dart';
import 'instruction_item.dart'; // Import your InstructionItem

class DetailsList extends StatefulWidget {
  final List<String> details;

  const DetailsList({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  State<DetailsList> createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  late List<bool> _checked;

  @override
  void initState() {
    super.initState();
    _checked = List<bool>.filled(widget.details.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(widget.details.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InstructionItem(
            number: index + 1,
            instruction: widget.details[index],
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
