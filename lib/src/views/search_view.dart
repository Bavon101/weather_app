import 'package:flutter/material.dart';
import 'package:weather_app/src/models/place_model.dart';
import 'package:weather_app/src/widgets/place_card.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    Key? key,required this.places
  }) : super(key: key);
  final List<PlacePrediction> places;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:places.isEmpty?const Center(
        child: Text("Search for any Location\ntry..Athi river",textAlign: TextAlign.center,),
      ) :ListView.separated(itemBuilder: (_,i) => PlaceCard(place: places[i]), separatorBuilder: (_,i) => const Divider(), itemCount: places.length),
    );
  }
}
