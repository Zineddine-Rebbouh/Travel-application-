// ignore_for_file: public_member_api_docs, sort_constructors_first
class TouristPlacesModel {
  final String name;
  final String image;
  TouristPlacesModel({
    required this.name,
    required this.image,
  });
}

List<TouristPlacesModel> touristPlaces = [
  TouristPlacesModel(name: "All", image: "assets/places/histo.png"),
  TouristPlacesModel(name: "Museums", image: "assets/places/musim.png"),
  TouristPlacesModel(name: "Cafes", image: "assets/places/coffe.png"),
  TouristPlacesModel(
      name: "Restaurants", image: "assets/places/restuarant.png"),
  TouristPlacesModel(name: "Beach", image: "assets/places/beach.png"),
  TouristPlacesModel(name: "Forest", image: "assets/places/beach.png"),
  TouristPlacesModel(name: "HistoricalSites", image: "assets/places/histo.png"),
  TouristPlacesModel(name: "Desert", image: "assets/places/beach.png"),
];
