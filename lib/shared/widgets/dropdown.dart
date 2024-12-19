import 'package:flutter/material.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';

class DropDownList<T> extends StatefulWidget {
  final double width;
  final double height;
  final Map<T, String>? options;
  final String? hintText;
  final ValueChanged<T?> onChanged;
  final bool? isLoading;
  final String? emptyMessage;
  final T? value;

  const DropDownList({
    Key? key,
    required this.width,
    required this.height,
    this.hintText,
    required this.onChanged,
    this.options,
    this.isLoading = false,
    this.emptyMessage = 'No data available',
    this.value,
  }) : super(key: key);

  @override
  _DropDownListState<T> createState() => _DropDownListState<T>();
}

class _DropDownListState<T> extends State<DropDownList<T>> {
  T? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant DropDownList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update current value if the parent provides a new value
    if (widget.value != oldWidget.value) {
      setState(() {
        _currentValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Current Widget Value: $_currentValue');
    print('Options: ${widget.options}');
    print(
        'Selected Value Display: ${_currentValue != null ? widget.options![_currentValue] : 'No value'}');

    return Container(
      width: widget.width,
      height: widget.height,
      padding:
          const EdgeInsets.symmetric(horizontal: smallSize, vertical: tinySize),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        border: Border.all(color: Theme.of(context).colorScheme.onTertiary),
        borderRadius: BorderRadius.circular(smallSize),
      ),
      child: widget.isLoading!
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ))
          : DropdownButton<T>(
              dropdownColor: Theme.of(context).colorScheme.onTertiary,
              isExpanded: true,
              value: _currentValue,
              hint: Text(
                _currentValue != null
                    ? widget.options![_currentValue]!
                    : widget.hintText ?? widget.emptyMessage!,
                style: TextStyle(
                  color: _currentValue != null
                      ? Theme.of(context).colorScheme.scrim
                      : Theme.of(context).colorScheme.tertiary,
                  fontFamily:
                      Theme.of(context).textTheme.bodyMedium?.fontFamily,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              icon: Icon(Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.tertiary, size: smallSize + 6.0),
              underline: const SizedBox(),
              onChanged: (T? newValue) {
                setState(() {
                  _currentValue = newValue;
                });
                widget.onChanged(newValue);
              },
              items: widget.options?.entries.map((entry) {
                    return DropdownMenuItem<T>(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontFamily,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList() ??
                  [],
            ),
    );
  }
}
