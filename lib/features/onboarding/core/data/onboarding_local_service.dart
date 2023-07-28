import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalService {
  static const _onboardingKey = "onboarding_key";

  Future<bool> save() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_onboardingKey, '1');
  }

  Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_onboardingKey);
  }

  Future<bool> remove() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_onboardingKey);
  }
}
