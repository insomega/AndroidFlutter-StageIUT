import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_convert_date_service.dart';

// ignore: must_be_immutable
class CustomDatePicker2 extends StatefulWidget {
  CustomDatePicker2({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePicker2> createState() => _CustomDatePicker2State();
}

class _CustomDatePicker2State extends State<CustomDatePicker2> {
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
  CustomTimePicker({super.key, required this.getDate, this.initialDate});
  ValueSetter<TimeOfDay> getDate;
  TimeOfDay? initialDate;
  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay date;

  @override
  void initState() {
    date = widget.initialDate ?? TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        TimeOfDay? newDate = await showTimePicker(
          context: context,
          initialTime: widget.initialDate ?? TimeOfDay.now(),
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
                "${ConvertDateService.Add_zero(date.hour)}:${ConvertDateService.Add_zero(date.minute)}",
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
class CustomDatePicker2Search extends StatefulWidget {
  CustomDatePicker2Search({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePicker2Search> createState() =>
      _CustomDatePicker2SearchState();
}

class _CustomDatePicker2SearchState extends State<CustomDatePicker2Search> {
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
class CustomDatePicker2Dialog extends StatefulWidget {
  CustomDatePicker2Dialog({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePicker2Dialog> createState() =>
      _CustomDatePicker2DialogState();
}

class _CustomDatePicker2DialogState extends State<CustomDatePicker2Dialog> {
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
class CustomDatePicker2Secondry extends StatefulWidget {
  CustomDatePicker2Secondry({super.key, required this.getDate});
  ValueSetter<DateTime> getDate;
  @override
  State<CustomDatePicker2Secondry> createState() =>
      _CustomDatePicker2SecondryState();
}

class _CustomDatePicker2SecondryState extends State<CustomDatePicker2Secondry> {
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
class CustomDatePicker2New extends StatefulWidget {
  const CustomDatePicker2New({
    super.key,
    required this.getDate,
    required this.icon,
    this.initialDate,
  });
  final ValueSetter<DateTime> getDate;
  final Widget icon;
  final DateTime? initialDate;
  @override
  State<CustomDatePicker2New> createState() => _CustomDatePicker2NewState();
}

class _CustomDatePicker2NewState extends State<CustomDatePicker2New> {
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
              if (newDate == null) {
                return;
              } else {
                setState(() {
                  date = newDate;
                  widget.getDate(date);
                });
              }
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
