import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({super.key, required this.getDate, this.initDate});
  ValueSetter<DateTime> getDate;
  final DateTime? initDate;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    if (widget.initDate != null) {
      date = widget.initDate!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(1900),
          lastDate: DateTime(2101),
          locale: Locale('fr'),
          helpText: GBSystem_Application_Strings.str_datePickerHelpText,
          cancelText: GBSystem_Application_Strings.str_annuler,
          confirmText: GBSystem_Application_Strings.str_done,
          errorFormatText: GBSystem_Application_Strings.str_datePickerInputHint,
          errorInvalidText: GBSystem_Application_Strings.str_datePickerInputHint,
          fieldHintText: GBSystem_Application_Strings.str_datePickerInputHint,
          fieldLabelText: GBSystem_Application_Strings.str_datePickerHelpText,
        );
        setState(() {
          if (newDate != null) {
            date = newDate;
          }

          widget.getDate(date);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.03), vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.02)),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const Icon(Icons.date_range),
            const SizedBox(width: 5),
            Text(
              "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTimePickerFrench extends StatefulWidget {
  final TimeOfDay? initialDate;
  final Function(TimeOfDay) onDateSelected;
  final double? width;
  final String? labelText;
  final Color? color;
  TimeOfDay? selectedDate;
  final bool enabled;
  CustomTimePickerFrench({Key? key, this.initialDate, required this.onDateSelected, this.width, this.labelText, this.color, required this.selectedDate, this.enabled = false}) : super(key: key);

  @override
  _CustomTimePickerFrenchState createState() => _CustomTimePickerFrenchState();
}

class _CustomTimePickerFrenchState extends State<CustomTimePickerFrench> {
  @override
  void initState() {
    super.initState();
    widget.selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: widget.selectedDate ?? TimeOfDay.now(), helpText: GBSystem_Application_Strings.str_datePickerHelpText, cancelText: GBSystem_Application_Strings.str_annuler, confirmText: GBSystem_Application_Strings.str_done, errorInvalidText: GBSystem_Application_Strings.str_datePickerInputHint);
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
        widget.onDateSelected(widget.selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled == true
          ? null
          : () {
              _selectDate(context);
            },
      child: Container(
        width: widget.width,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: widget.enabled ? Colors.grey.shade200 : widget.color, borderRadius: BorderRadius.circular(8)),
        child: InputDecorator(
          decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), labelText: widget.labelText, border: OutlineInputBorder()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.selectedDate != null ? "${widget.selectedDate?.hour.toString().padLeft(2, '0')}:${widget.selectedDate?.minute.toString().padLeft(2, '0')}" : "", style: TextStyle(fontSize: 12)),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).colorScheme.secondary),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2000), lastDate: DateTime(2100));
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.secondary),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('choisie la date', style: const TextStyle(fontSize: 20, color: Colors.black)),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2000), lastDate: DateTime(2100));
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.primary),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Date', style: const TextStyle(fontSize: 14, color: Colors.white)),
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
  State<CustomDatePickerSecondry> createState() => _CustomDatePickerSecondryState();
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2000), lastDate: DateTime(2100));
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).colorScheme.secondary),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('choisie la date', style: const TextStyle(fontSize: 14, color: Colors.black)),
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
  const CustomDatePickerNew({super.key, required this.getDate, required this.icon, this.initialDate});
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
            DateTime? newDate = await showDatePicker(context: context, initialDate: widget.initialDate!, firstDate: DateTime(2000), lastDate: DateTime(2100));
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Theme.of(context).colorScheme.primary),
                child: Center(
                  child: Text(
                    "${date.day}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Theme.of(context).colorScheme.primary),
                child: Center(
                  child: Text(
                    "${date.month}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Theme.of(context).colorScheme.primary),
                child: Center(
                  child: Text(
                    "${date.year}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomDatePickerFrench extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;
  final double? width;
  final String? labelText;
  final Color? color;
  DateTime? selectedDate;
  final bool enabled;
  CustomDatePickerFrench({Key? key, this.initialDate, required this.onDateSelected, this.width, this.labelText, this.color, required this.selectedDate, this.enabled = false}) : super(key: key);

  @override
  _CustomDatePickerFrenchState createState() => _CustomDatePickerFrenchState();
}

class _CustomDatePickerFrenchState extends State<CustomDatePickerFrench> {
  @override
  void initState() {
    super.initState();
    widget.selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      locale: Locale('fr'),
      helpText: GBSystem_Application_Strings.str_datePickerHelpText,
      cancelText: GBSystem_Application_Strings.str_annuler,
      confirmText: GBSystem_Application_Strings.str_done,
      errorFormatText: GBSystem_Application_Strings.str_datePickerInputHint,
      errorInvalidText: GBSystem_Application_Strings.str_datePickerInputHint,
      fieldHintText: GBSystem_Application_Strings.str_datePickerInputHint,
      fieldLabelText: GBSystem_Application_Strings.str_datePickerHelpText,
    );
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
        widget.onDateSelected(widget.selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled == true
          ? null
          : () {
              _selectDate(context);
            },
      child: Container(
        width: widget.width,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: widget.enabled ? Colors.grey.shade200 : widget.color, borderRadius: BorderRadius.circular(8)),
        child: InputDecorator(
          decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), labelText: widget.labelText, border: OutlineInputBorder()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.selectedDate != null
                    ? "${widget.selectedDate?.day.toString().padLeft(2, '0')}/${widget.selectedDate?.month.toString().padLeft(2, '0')}/${widget.selectedDate?.year}"
                    // '${widget.selectedDate?.year}-${widget.selectedDate?.month.toString().padLeft(2, '0')}-${widget.selectedDate?.day.toString().padLeft(2, '0')}'
                    : "",
                style: TextStyle(fontSize: 12),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
