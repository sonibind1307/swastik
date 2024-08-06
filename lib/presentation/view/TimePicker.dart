import 'package:flutter/material.dart';

class TimePicker30MinuteInterval extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  TimePicker30MinuteInterval(
      {required this.initialTime, required this.onTimeChanged});

  @override
  _TimePicker30MinuteIntervalState createState() =>
      _TimePicker30MinuteIntervalState();
}

class _TimePicker30MinuteIntervalState
    extends State<TimePicker30MinuteInterval> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Time'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<int>(
            value: selectedTime.hour,
            onChanged: (int? newHour) {
              setState(() {
                selectedTime =
                    TimeOfDay(hour: newHour!, minute: selectedTime.minute);
              });
            },
            items: List.generate(24, (index) => index)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString().padLeft(2, '0')),
              );
            }).toList(),
          ),
          DropdownButton<int>(
            value: null,
            onChanged: (int? newMinute) {
              setState(() {
                selectedTime =
                    TimeOfDay(hour: selectedTime.hour, minute: newMinute!);
              });
            },
            items: [0, 30].map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString().padLeft(2, '0')),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onTimeChanged(selectedTime);
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
