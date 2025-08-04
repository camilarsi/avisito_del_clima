import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Core/Utils/ui_constants.dart';
import '../Blocs/location_bloc.dart';
import 'floating_bee.dart';

class CitySearchBar extends StatelessWidget {
  CitySearchBar({required this.solidBorder, super.key});

  final bool solidBorder;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Ciudad',
        labelStyle: GoogleFonts.dmSans(
          fontSize: 16,
          color: AppColors.dark.getColor,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(),
        hintText: 'Ej: Buenos Aires, Madrid, etc.',
        prefixIcon: Icon(Icons.location_city, color: AppColors.dark.getColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: solidBorder ? AppColors.dark.getColor : Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
          borderSide: BorderSide(
            color: solidBorder ? Colors.teal : Colors.transparent,
            width: 1,
          ),
        ),
        fillColor: AppColors.foreground.getColor,
        filled: true,
      ),
      onSubmitted: (city) {
        _searchCity(context);
      },
    );
  }

  void _searchCity(BuildContext context) {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      context.read<LocationBloc>().sink.add(
        LocationSearchByCity(cityName: city),
      );
    }
  }
}
