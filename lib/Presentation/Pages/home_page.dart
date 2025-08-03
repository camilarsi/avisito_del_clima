import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Domain/Entities/location.dart';
import '../Blocs/location_bloc.dart';
import '../Blocs/weather_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            TextField(
              decoration: const InputDecoration(
                labelText: 'Ingresa la ciudad',
              ), //TODO const
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  locationBloc.sink.add(
                    LocationEventManuallySelected(
                      location: Location(
                        latitude: -34.6037,
                        longitude: -58.3816,
                      ),
                    ),
                  ); // TODO removed hardcoded
                }
              },
            ),

            const SizedBox(height: 24),
            StreamBuilder(
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
            ),
          ],
        ),
      ),
    );
  }
}
