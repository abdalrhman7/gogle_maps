import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Place_suggestion.dart';
import '../models/place.dart';
import '../models/place_directions.dart';
import '../models/weather.dart';
import '../webservices/places_webservices.dart';

class MapsRepository{
  final PlacesWebservices placesWebservices;

  MapsRepository(this.placesWebservices);

  Future<List<PlaceSuggestion>> fetchSuggestions(String place, String sessionToken)async{
    final suggestions = await placesWebservices.fetchSuggestions(place, sessionToken);

   return suggestions.map((suggestions) =>  PlaceSuggestion.fromJson(suggestions)).toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken)async{
    final place = await placesWebservices.getPlaceLocation(placeId, sessionToken);

   // var readyPlace  =   Place.fromJson(place);

   return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(LatLng origin , LatLng destination)async{
    final place = await placesWebservices.getDirections(origin, destination);
    return PlaceDirections.fromJson(place);
  }


  Future<OpenWeather> getWeather(dynamic latitude , dynamic longitude)async{
    final weather = await placesWebservices.getWeather(latitude, longitude);
    return OpenWeather.fromJson(weather);
  }
}