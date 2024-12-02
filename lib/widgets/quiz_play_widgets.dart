import 'package:flutter/material.dart';

class OptionItem extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  const OptionItem(
      {super.key,
      required this.option,
      required this.description,
      required this.correctAnswer,
      required this.optionSelected});

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.description == widget.optionSelected
                      ? widget.optionSelected == widget.correctAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey,
                  width: 1.5),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(widget.option,
                style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? widget.optionSelected == widget.correctAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey,
                )),
          ),
          const SizedBox(width: 8),
          Text(widget.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )),
        ],
      ),
    );
  }
}
