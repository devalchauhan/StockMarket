import 'package:stock_market/app/data/constants.dart';

int getDaysBeforeByInterval(String interval) {
  switch (interval) {
    case Constants.intervalDaily:
      return 1;
    case Constants.intervalWeekly:
      return 7;
    case Constants.intervalMonthly:
      return 30;
    case Constants.intervalYearly:
      return 365;
  }
  return 1;
}
