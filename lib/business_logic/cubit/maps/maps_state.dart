part of 'maps_cubit.dart';

@immutable
abstract class MapsState {}

class MapsInitial extends MapsState {}

class PlacesLoaded extends MapsState {
  final List<PlaceSuggestion> places;

  PlacesLoaded(this.places);

}

class PlaceDetailsLoaded extends MapsState {
  final Place place;

  PlaceDetailsLoaded(this.place);

}


class DirectionsLoaded extends MapsState {
  final PlaceDirections placeDirections;

  DirectionsLoaded(this.placeDirections);

}


class WeatherLoaded extends MapsState {
  final OpenWeather openWeather;

  WeatherLoaded(this.openWeather);

}
