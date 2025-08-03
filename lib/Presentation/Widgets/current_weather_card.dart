import 'package:avisito_del_clima/Domain/Entities/weather.dart';
import 'package:avisito_del_clima/Presentation/Widgets/weather_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/Utils/ui_constants.dart';
import '../Blocs/weather_bloc.dart';

class CurrentLocationWeather extends StatelessWidget {
  const CurrentLocationWeather({super.key, required this.weatherBloc});

  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: weatherBloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (snapshot.hasData) {
          if (state == null || state is WeatherStateLoading) {
            return Center(
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is WeatherStateError) {
            return Text(state.error);
          }
          if (state is WeatherStateSuccessful) {
            final weather = state.weather;
            return Column(
              children: [
                buildHeader(weather),
                SizedBox(height: 24),
                WeatherDetails(weather: weather),
              ],
            );
          }
        }
        return Container();
      },
    );
  }
}

Column buildNextDaysWeather() => Column();

Container buildHeader(Weather weather) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF26A69A), Color(0xFF80CBC4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.5, 2.0],
      ),
      borderRadius: BorderRadius.circular(32),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tiempo',
          style: GoogleFonts.dmSans(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weather.city,
          style: GoogleFonts.dmSans(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${weather.temperature}°',
              style: GoogleFonts.dmSans(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(weather.icon, size: 120, color: Colors.white.withOpacity(0.5)),
          ],
        ),
        Text(
          weather.condition, //TODO internationalization
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
