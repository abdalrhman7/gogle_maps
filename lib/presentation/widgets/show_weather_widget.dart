import 'package:flutter/material.dart';
import 'package:google_map/constnats/my_colors.dart';

import '../../data/models/weather.dart';

class ShowWeatherWidget extends StatelessWidget {
  const ShowWeatherWidget({super.key, required this.weather, required this.getWeather});

  final OpenWeather? weather;
  final VoidCallback getWeather;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
      right: 160,
      left: -10,
      bottom: 540,
      child: GestureDetector(
        onTap: getWeather,
        child: Card(
          elevation: 6,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(22), bottomLeft: Radius.circular(22) , bottomRight:  Radius.circular(22)),
          ),
          margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          color: Colors.white,
          child: ListTile(
            // dense: true,
            horizontalTitleGap: -5,
            leading: const Icon(
              Icons.sunny,
              color: MyColors.blue,
              size: 20,
            ),
            title: RichText(
              text: TextSpan(
                  text: weather == null
                      ? 'Tap to get Weather'
                      : '${weather!.main!.temp!.toInt()} °',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: weather == null
                          ? '' :' ${weather!.weather![0].description}',
                      style: const TextStyle(color: MyColors.blue),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
