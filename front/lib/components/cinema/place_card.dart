import 'package:flutter/material.dart';
import 'package:flutter_movie/components/cinema/order_dialog.dart';
import 'package:flutter_movie/models/cinema/place.dart';
import 'package:flutter_movie/utils/helpers.dart';

// ignore: must_be_immutable
class PlaceCard extends StatefulWidget {
  Place place;
  String cinemaId;

  PlaceCard({
    super.key,
    required this.place,
    required this.cinemaId,
  });

  @override
  PlaceCardState createState() => PlaceCardState();
}

class PlaceCardState extends State<PlaceCard> {
  void _toggleOrder() async {
    if(widget.place.isOrdered) {
      Helper.showErrorDialog(context, 'Place is already ordered!');
      return;
    }
    setState(() {
      widget.place.isOrdered = !widget.place.isOrdered;
    });
    var dialog = OrderDialog(place: widget.place,cinemaId: widget.cinemaId,);
    var res = await showDialog<Place>(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
    if (res != null && !res.isOrdered) {
      setState(() {
        widget.place.isOrdered = res.isOrdered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOrder,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: widget.place.isOrdered ? Colors.red : Colors.green,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${widget.place.number}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      
    );
  }
}
