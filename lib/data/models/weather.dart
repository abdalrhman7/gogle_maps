class OpenWeather {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? dt;

  OpenWeather(
      {this.coord,
        this.weather,
        this.base,
        this.main,
        this.dt,
        });

  OpenWeather.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add( Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ?  Main.fromJson(json['main']) : null;
    dt = json['dt'];
  }


}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

}

class Weather {
  int? id;
  String? main;
  String? description;

  Weather({this.id, this.main, this.description, });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
  }

}

class Main {
  double? temp;
  Main(
      {this.temp,
 });

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
  }

}
