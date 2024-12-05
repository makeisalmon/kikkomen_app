import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const NumberPicker({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _currentValue++;
      widget.onChanged(_currentValue);
    });
  }

  void _decrement() {
    if (_currentValue > 1) {
      setState(() {
        _currentValue--;
        widget.onChanged(_currentValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: IconButton(
            onPressed: _decrement,
            icon: const Icon(Icons.remove),
            color: Theme.of(context).colorScheme.onPrimary
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '$_currentValue',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: IconButton(
            onPressed: _increment,
            icon: const Icon(Icons.add),
            color: Theme.of(context).colorScheme.onPrimary
          ),
        ),
      ],
    );
  }
}