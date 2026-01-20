import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100));
        setState(() {
          if (newDate != null) {
            date = newDate;
          }

          widget.getDate(date);
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal:
                  GBSystem_ScreenHelper.screenWidthPercentage(context, 0.03),
              vertical:
                  GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white),
          child: Row(
            children: [
              const Icon(
                Icons.date_range,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${date.day}/${date.month}/${date.year}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class CustomTimePicker extends StatefulWidget {
  CustomTimePicker({super.key, required this.getDate});
  ValueSetter<TimeOfDay> getDate;
  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay date = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        TimeOfDay? newDate = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (newDate == null) {
          return;
        } else {
          setState(() {
            date = newDate;
            widget.getDate(date);
          });
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Row(
            children: [
              const Icon(
                Icons.timer,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text(
                "${date.hour}:${date.minute}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class CustomDatePickerSearch extends StatefulWidget {
  CustomDatePickerSearch({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePickerSearch> createState() => _CustomDatePickerSearchState();
}

class _CustomDatePickerSearchState extends State<CustomDatePickerSearch> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100));
            setState(() {
              if (newDate != null) {
                date = newDate;
              }
              widget.getDate(date);
            });
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'choisie la date',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomDatePickerDialog extends StatefulWidget {
  CustomDatePickerDialog({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100));
            setState(() {
              if (newDate != null) {
                date = newDate;
              }
              widget.getDate(date);
            });
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Date',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomDatePickerSecondry extends StatefulWidget {
  CustomDatePickerSecondry({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePickerSecondry> createState() =>
      _CustomDatePickerSecondryState();
}

class _CustomDatePickerSecondryState extends State<CustomDatePickerSecondry> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100));
            setState(() {
              if (newDate != null) {
                date = newDate;
              }
              widget.getDate(date);
            });
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'choisie la date',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomDatePickerNew extends StatefulWidget {
  const CustomDatePickerNew({
    super.key,
    required this.getDate,
    required this.icon,
    this.initialDate,
  });
  final ValueSetter<DateTime> getDate;
  final Widget icon;
  final DateTime? initialDate;
  @override
  State<CustomDatePickerNew> createState() => _CustomDatePickerNewState();
}

class _CustomDatePickerNewState extends State<CustomDatePickerNew> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    date = widget.initialDate ?? DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.initialDate!,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100));
              setState(() {
                if (newDate != null) {
                  date = newDate;
                }
                widget.getDate(date);
              });
            },
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary),
                  child: Center(
                    child: Text(
                      "${date.day}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary),
                  child: Center(
                    child: Text(
                      "${date.month}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary),
                  child: Center(
                    child: Text(
                      "${date.year}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
            //    Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       padding: const EdgeInsets.all(20),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20), color: Colors.white),
            //       child: Text(
            //         "${date.day}/${date.month}/${date.year}",
            //         style: const TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.black),
            //       ),
            //     ),
            //   ),
            ),
      ],
    );
  }
}
