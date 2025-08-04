import 'package:avisito_del_clima/Core/Utils/ui_constants.dart';
import 'package:avisito_del_clima/Infraestructure/Injection/dependencies_injector.dart';
import 'package:avisito_del_clima/Presentation/Blocs/location_bloc.dart';
import 'package:avisito_del_clima/Presentation/Blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'Infraestructure/Routing/app_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final di = DependenciesInjector();

  runApp(
    MultiProvider(
      providers: [
        Provider<LocationBloc>.value(value: di.locationBloc),
        Provider<WeatherBloc>.value(value: di.weatherBloc),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UIConstants.appTitle,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
    );
  }
}
