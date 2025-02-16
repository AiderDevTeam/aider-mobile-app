import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashService {
  static Future<void> recordCrashError(Object error, StackTrace? stack,
      {dynamic reason, bool fatal = false}) async {
    try {
      await FirebaseCrashlytics.instance
          .recordError(error, stack, reason: reason, fatal: fatal)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (t) {
      log(t.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  static void setCrashKey(String key, Object value) {
    FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

  static void setUserIdentifier(String userExternalId) {
    FirebaseCrashlytics.instance.setUserIdentifier(userExternalId);
  }

  static Future<void> setCrashlyticsCollectionEnabled(bool inDevMode) async {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(inDevMode);
  }
}
