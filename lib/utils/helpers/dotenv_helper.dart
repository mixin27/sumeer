import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvHelper {
  static Future<void> loadEnv(String envPath) async {
    await dotenv.load(fileName: envPath);
  }

  static String getEnvValue(String key) => dotenv.env[key] ?? "";
}
