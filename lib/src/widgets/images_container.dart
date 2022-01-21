import 'package:flutter/material.dart';
import 'package:weather_app/src/models/place_data_model.dart';
import 'package:weather_app/src/resources/keys.dart';
import 'package:weather_app/src/widgets/CustomImage.dart';

import '../short_calls.dart';

class ImagesContainerView extends StatelessWidget {
  const ImagesContainerView({Key? key,required this.photos}) : super(key: key);
  final List<Photo> photos;
// this widget display the images
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context),
      decoration: const BoxDecoration(
          color: Color(0xffffd5a0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 5,
              width:width(context) * .25,
              decoration: BoxDecoration(
                  color:  Colors.green ,
                  borderRadius: BorderRadius.circular(20)),
            ),
             const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Photos',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                    
                  )),
            ),
            SizedBox(
              width: width(context),
              height: height(context)*.30,
              child: ListView.builder(
                itemCount: photos.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomImageCard(
                      width: width(context)*.45,
                      imageUrl: photoUrl(photos[i]))),
                )),
            )
          ],
        ),
      ),
    );
  }

  String  photoUrl (Photo p) => "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${p.photoReference}&key=${Keys.gmapKey}";
}
