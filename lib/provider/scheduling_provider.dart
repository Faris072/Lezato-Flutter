import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:lezato/utils/background_service.dart';
import 'package:lezato/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledInfo(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      debugPrint('Scheduling info activated');
      debugPrint(DateTimeHelper.format().toIso8601String());
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint("Schedule info cancelled");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
