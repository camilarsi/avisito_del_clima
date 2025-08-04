import 'package:avisito_del_clima/Core/Utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Blocs/location_bloc.dart';
import '../Blocs/weather_bloc.dart';
import '../Widgets/current_weather_card.dart';
import '../Widgets/floating_bee.dart';
import '../Widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) async {
    if (appState == AppLifecycleState.resumed) {
      context.read<LocationBloc>().sink.add(LocationCheckPermissionStatus());
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationBloc = context.read<LocationBloc>();
    final weatherBloc = context.read<WeatherBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 12, left: 8.0, right: 8.0),
          child: Column(
            children: [
              Text(
                UIConstants.appTitle,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFontSizes.xxl,
                  color: AppColors.dark.getColor,
                ),
              ),
              FloatingBee(),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.secondary.getColor,
        centerTitle: false,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF26A69A), Color(0xFF80CBC4)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.5, 2.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: StreamBuilder<LocationState>(
            stream: locationBloc.locationState,
            builder: (context, snapshot) {
              final locationState = snapshot.data;

              if (locationState is LocationLoading) {
                return Center(
                  child: SizedBox.square(
                    dimension: 30,
                    child: CircularProgressIndicator(
                      color: AppColors.foreground.getColor,
                    ),
                  ),
                );
              } else if (locationState is LocationLoaded) {
                return CurrentLocationWeather(weatherBloc: weatherBloc);
              } else if (locationState is LocationPermissionDenied) {
                return Column(children: [_ManualCityInput(), Spacer()]);
              } else if (locationState is LocationError) {
                return Text('Error: ${locationState.message}');
              }
              return const Text(UIConstants.waitingLocationMessage);
            },
          ),
        ),
      ),
    );
  }
}

class _ManualCityInput extends StatefulWidget {
  const _ManualCityInput({super.key});

  @override
  State<_ManualCityInput> createState() => _ManualCityInputState();
}

class _ManualCityInputState extends State<_ManualCityInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.foreground.getColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Text(
              UIConstants.locationPermissionDialogTitle,
              style: GoogleFonts.dmSans(
                fontSize: AppFontSizes.lg,
                fontWeight: FontWeight.bold,
                color: AppColors.dark.getColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              UIConstants.locationPermissionRequest,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: AppFontSizes.sm,
                color: AppColors.dark.getColor,
              ),
            ),
            const SizedBox(height: 16),
            CitySearchBar(solidBorder: true),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: _searchCity,
                      icon: const Icon(Icons.search),
                      label: const Text(UIConstants.searchButton),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.foreground.getColor,
                        backgroundColor: AppColors.primary.getColor,
                        textStyle: GoogleFonts.dmSans(
                          fontSize: AppFontSizes.sm,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        context.read<LocationBloc>().sink.add(
                          LocationRequestPermission(),
                        );
                      },
                      icon: const Icon(Icons.location_on),
                      label: const Text(UIConstants.givPermissionButton),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.foreground.getColor,
                        backgroundColor: AppColors.primary.getColor,
                        textStyle: GoogleFonts.dmSans(
                          fontSize: AppFontSizes.sm,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchCity() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      context.read<LocationBloc>().sink.add(
        LocationSearchByCity(cityName: city),
      );
    }
  }
}
