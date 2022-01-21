import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/src/models/place_model.dart';
import 'package:weather_app/src/short_calls.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({Key? key, required this.place}) : super(key: key);
  final PlacePrediction place;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool loading = false;
  Future<void> _updateLoadingStatus() async {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              widget.place.structuredFormatting?.mainText ?? "",
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 1,
            ),
          ),
          const Spacer(),
          if (loading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
        ],
      ),
      subtitle: SizedBox(
        width: width(context) * .90,
        child: Text(
          widget.place.structuredFormatting?.secondaryText ?? "",
          overflow: TextOverflow.fade,
          softWrap: true,
          maxLines: 1,
        ),
      ),
      onTap: () async {
        _updateLoadingStatus();
       await weatherCotroller.decodeSearchedQuery(widget.place.placeId!);
        _updateLoadingStatus();
        Navigator.pushNamed(context, '/search_data');
      },
    );
  }
}
