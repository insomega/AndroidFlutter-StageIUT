import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class RatingsBarWidget extends StatefulWidget {
  const RatingsBarWidget({
    super.key,
    required this.onRatingUpdate,
    this.initialRating,
    this.count = 5,
  });

  final void Function(double) onRatingUpdate;
  final double? initialRating;
  final int count;

  @override
  State<RatingsBarWidget> createState() => _RatingsBarWidgetState();
}

class _RatingsBarWidgetState extends State<RatingsBarWidget> {
  Color colorStar = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 20,
      initialRating: widget.initialRating ?? 0,
      //  widget.initialRating ?? ((widget.count) / 2),
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: widget.count,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 8),
      itemBuilder: (context, a) {
        // print(a);
        return Icon(
          CupertinoIcons.star_fill,
          color:
              // a <= (widget.count / 3)
              //     ? Colors.red
              //     : a >= (widget.count / 2.5) && a <= (widget.count / 1.7)
              //         ? Colors.amber
              //         : Colors.green,
              colorStar,
        );
      },
      onRatingUpdate: (value) {
        // colorStar = value <= (widget.count / 3)
        //     ? Colors.red
        //     : value >= (widget.count / 3) && value <= (widget.count / 1.5)
        //         ? Colors.amber
        //         : Colors.green;
        setState(() {});
        widget.onRatingUpdate(value);
      },
      updateOnDrag: false,
      glowColor: GbsSystemServerStrings.str_primary_color,
    );
  }
}

//////////////////////////////////////
class RatingsBarFacesWidget extends StatefulWidget {
  const RatingsBarFacesWidget({
    super.key,
    required this.onRatingUpdate,
    this.initialRating,
    this.count = 5,
  });

  final void Function(double) onRatingUpdate;
  final double? initialRating;
  final int count;

  @override
  State<RatingsBarFacesWidget> createState() => _RatingsBarFacesWidgetState();
}

class _RatingsBarFacesWidgetState extends State<RatingsBarFacesWidget> {
  @override
  Widget build(BuildContext context) {
    print('sqskqskqlqsk ${widget.initialRating}');
    return RatingBar.builder(
      itemSize: 25,
      initialRating: widget.initialRating ?? 0,
      // widget.initialRating ?? ((widget.count) / 2),
      itemCount: widget.count,
      allowHalfRating: false,
      minRating: 0,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: (index <= widget.count / 5)
                ? Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  )
                : index <= widget.count / 3
                    ? Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      )
                    : (index <= widget.count / 2)
                        ? Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          )
                        : (index <= widget.count / 1.5)
                            ? Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              )
                            : Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              ));
      },

      //   if (index <= widget.count / 5) {
      //     return Icon(
      //       Icons.sentiment_very_dissatisfied,
      //       color: Colors.red,
      //     );
      //   } else if (index <= widget.count / 3) {
      //     return Icon(
      //       Icons.sentiment_dissatisfied,
      //       color: Colors.redAccent,
      //     );
      //   } else if (index <= widget.count / 1.5) {
      //     return Icon(
      //       Icons.sentiment_neutral,
      //       color: Colors.amber,
      //     );
      //   } else if (index <= widget.count / 0.5) {
      //     return Icon(
      //       Icons.sentiment_satisfied,
      //       color: Colors.lightGreen,
      //     );
      //   } else {
      //     return Icon(
      //       Icons.sentiment_very_satisfied,
      //       color: Colors.green,
      //     );
      //   }

      //   switch (index) {
      //     case 0:
      //       return Icon(
      //         Icons.sentiment_very_dissatisfied,
      //         color: Colors.red,
      //       );

      //     case 1:
      //       return Icon(
      //         Icons.sentiment_dissatisfied,
      //         color: Colors.redAccent,
      //       );
      //     case 2:
      //       return Icon(
      //         Icons.sentiment_neutral,
      //         color: Colors.amber,
      //       );
      //     case 3:
      //       return Icon(
      //         Icons.sentiment_satisfied,
      //         color: Colors.lightGreen,
      //       );
      //     case 4:
      //       return Icon(
      //         Icons.sentiment_very_satisfied,
      //         color: Colors.green,
      //       );
      //     default:
      //       return Icon(
      //         Icons.sentiment_very_satisfied,
      //         color: Colors.green,
      //       );
      //   }
      // },
      onRatingUpdate: widget.onRatingUpdate,
    );
  }
}
