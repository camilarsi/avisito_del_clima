import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Blocs/location_bloc.dart';
import '../Blocs/weather_bloc.dart';

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

  /*  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Permiso de Ubicación'),
        content: const Text(
          'Para obtener el clima local automáticamente, necesitamos acceso a tu ubicación.\n\nTambién puedes buscar el clima de cualquier ciudad manualmente.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Usar entrada manual'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<LocationBloc>().sink.add(
                LocationRequestPermission(),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Permitir ubicación'),
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final locationBloc = context.read<LocationBloc>();
    final weatherBloc = context.read<WeatherBloc>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder<LocationState>(
              stream: locationBloc.locationState,
              builder: (context, snapshot) {
                final locationState = snapshot.data;

                if (locationState is LocationLoading) {
                  return CircularProgressIndicator();
                } else if (locationState is LocationLoaded) {
                  return Column(
                    children: [
                      Text(
                        'Lat: ${locationState.location.latitude}, Lon: ${locationState.location.longitude}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _CurrentLocationWeather(weatherBloc: weatherBloc),
                    ],
                  );
                } else if (locationState is LocationPermissionDenied) {
                  return _ManualCityInput();
                } else if (locationState is LocationError) {
                  return Text('Error: ${locationState.message}');
                }
                return const Text('Esperando ubicacion');
              },
            ),
            const SizedBox(height: 24),
          ],
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
    return Column(
      children: [
        const Text(
          'Permisos de ubicación no otorgados',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Puedes buscar el clima de cualquier ciudad o permitir el acceso a tu ubicación',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Ciudad',
            border: OutlineInputBorder(),
            hintText: 'Ej: Buenos Aires, Madrid, etc.',
            prefixIcon: Icon(Icons.location_city),
          ),
          onSubmitted: (city) {
            _searchCity();
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _searchCity,
                icon: const Icon(Icons.search),
                label: const Text('Buscar'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<LocationBloc>().sink.add(
                    LocationRequestPermission(),
                  );
                },
                icon: const Icon(Icons.location_on),
                label: const Text('Permitir ubicación'),
              ),
            ),
          ],
        ),
      ],
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

class _CurrentLocationWeather extends StatelessWidget {
  const _CurrentLocationWeather({super.key, required this.weatherBloc});

  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: weatherBloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (snapshot.hasData) {
          if (state == null || state is WeatherStateLoading) {
            return CircularProgressIndicator();
          }
          if (state is WeatherStateError) {
            return Text(state.error);
          }
          if (state is WeatherStateSuccessful) {
            final weather = state.weather;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ciudad: ${weather.city}'),
                Text('Temperature: ${weather.temperature}'),
              ],
            );
          }
        }
        return Container();
      },
    );
  }
}
