import 'package:flutter/material.dart';
import 'package:travel_app/models/tourist_places_model.dart';

class TouristPlaces extends StatelessWidget {
  final Function(String type) onTypeSelected;

  const TouristPlaces({Key? key, required this.onTypeSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              onTypeSelected(touristPlaces[index].name);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.black), // Add border here
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16, // Set the radius to manipulate width and height
                  child: Image.asset(
                    touristPlaces[index].image,
                    width: 32, // Set width of the Image widget
                    height: 32, // Set height of the Image widget
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Text(touristPlaces[index].name),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.only(right: 10)),
        itemCount: touristPlaces.length,
      ),
    );
  }
}
