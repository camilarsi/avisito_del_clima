import 'package:avisito_del_clima/Core/Utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Domain/Entities/weather.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({required this.weather, super.key});

  final Weather weather;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildDetailsSection(weather)],
      ),
    );
  }

  Widget _buildDetailsSection(Weather weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          UIConstants.weatherDetailsSectionTitle,
          style: GoogleFonts.dmSans(
            fontSize: AppFontSizes.lg,
            fontWeight: FontWeight.bold,
            color: AppColors.dark.getColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _DetailItem(
              icon: Icons.thermostat,
              label: 'S. térmica',
              value: weather.feelsLike.toString(),
            ),
            _DetailItem(
              icon: Icons.air,
              label: 'Viento',
              value: weather.wind.toString(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _DetailItem(
              icon: Icons.water_drop_outlined,
              label: 'Humedad',
              value: weather.humidity.toString(),
            ),
            _DetailItem(
              icon: Icons.wb_sunny_outlined,
              label: 'índice UV',
              value: weather.uv.toString(),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primary.getColor, size: 40),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.dmSans(
                color: AppColors.dark.getColor,
                fontSize: AppFontSizes.xs,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSizes.sm,
                color: AppColors.dark.getColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
