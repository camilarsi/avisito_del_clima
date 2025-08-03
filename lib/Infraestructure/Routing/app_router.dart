import 'package:avisito_del_clima/Infraestructure/Routing/routes.dart';
import 'package:flutter/material.dart';

import '../../Presentation/Pages/home_page.dart';
import '../Utils/constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text(Constants.routeNotFoundMessage)),
          ),
        );
    }
  }
}
