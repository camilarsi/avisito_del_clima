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
        color: Colors.white,
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
        children: [
          //_buildForecastSection(),
          _buildDetailsSection(weather),
        ],
      ),
    );
  }

  /*Widget _buildForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Próximos días',
          style: GoogleFonts.dmSans(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.dark.getColor,
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _ForecastCard(
                day: 'Mar',
                icon: Icons.cloud_outlined,
                maxTemp: 17,
                minTemp: 10,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ForecastCard(
                day: 'Mié',
                icon: Icons.grain_outlined,
                maxTemp: 14,
                minTemp: 9,
                isSelected: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ForecastCard(
                day: 'Jue',
                icon: Icons.wb_sunny_outlined,
                maxTemp: 18,
                minTemp: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }*/

  Widget _buildDetailsSection(Weather weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detalles',
          style: GoogleFonts.dmSans(
            fontSize: 22,
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

class _ForecastCard extends StatelessWidget {
  final String day;
  final IconData icon;
  final int maxTemp;
  final int minTemp;
  final bool isSelected;

  const _ForecastCard({
    required this.day,
    required this.icon,
    required this.maxTemp,
    required this.minTemp,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD1E7FF) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.dark.getColor,
            ),
          ),
          const SizedBox(height: 12),
          Icon(
            icon,
            size: 40,
            color: isSelected ? const Color(0xFF26A69A) : Colors.grey.shade600,
          ),
          const SizedBox(height: 12),
          Text(
            '$maxTemp° $minTemp°',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2E3A47),
            ),
          ),
        ],
      ),
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.dark.getColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
