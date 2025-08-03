import 'package:shared_preferences/shared_preferences.dart';

class PermissionStatusService {
  static const _hasAskedLocationKey = 'has_Asked_location_permission';

  Future<bool> hasAlreadyAsked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasAskedLocationKey) ?? false;
  }

  Future<void> setAsked() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasAskedLocationKey, true);
  }
}
