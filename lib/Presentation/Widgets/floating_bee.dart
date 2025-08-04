import 'package:flutter/material.dart';

class FloatingBee extends StatefulWidget {
  const FloatingBee({super.key});

  @override
  State<FloatingBee> createState() => _FloatingBeeState();
}

class _FloatingBeeState extends State<FloatingBee> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) => _showOverlay());
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final topPadding = MediaQuery.of(context).padding.top;
        return Positioned(
          top: topPadding,
          right: 20,
          child: SizedBox(
            height: 80,
            child: Image.asset('assets/tiempito.png', fit: BoxFit.contain),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
