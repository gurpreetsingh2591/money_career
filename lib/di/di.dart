import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logger/logger_service.dart';
import '../utils/shared_preferences/shared_prefs.dart';

Future<void> setupLocator({bool isDebug = false}) async {
  Log.tag = 'moneyCarerFlutter';
  Log().d('Running ${isDebug ? 'debug' : 'release'} version...');
  await _initMisc();
}

Future<void> _initMisc() async {
  SharedPrefs.init(await SharedPreferences.getInstance());
}
