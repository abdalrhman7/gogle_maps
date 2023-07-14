
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../data/models/Place_suggestion.dart';
import '../../../data/models/place.dart';
import '../../../data/models/place_directions.dart';
import '../../../data/models/weather.dart';
import '../../../data/repository/maps_repo.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;
  MapsCubit(this.mapsRepository) : super(MapsInitial());

  void emitPlaceSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String place, String sessionToken) {
    mapsRepository.getPlaceLocation(place, sessionToken).then((place) {
      emit(PlaceDetailsLoaded(place));
    });
  }


  void emitPlaceDirections(LatLng origin, LatLng destination) {
    mapsRepository.getDirections(origin, destination).then((destinations) {
      emit(DirectionsLoaded(destinations));
    });
  }


 Future<void> emitWeather(dynamic latitude , dynamic longitude) async{
   await  mapsRepository.getWeather(latitude, longitude).then((weather) {
      emit(WeatherLoaded(weather));
    });
    }

}
