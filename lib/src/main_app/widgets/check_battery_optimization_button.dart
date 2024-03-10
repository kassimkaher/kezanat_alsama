import 'package:lucide_icons/lucide_icons.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:ramadan/src/core/widget/jb_button_mix.dart';
import 'package:ramadan/utils/utils.dart';

class ChekBatteryOptimizeIsDisable extends StatefulWidget {
  const ChekBatteryOptimizeIsDisable({
    super.key,
  });

  @override
  State<ChekBatteryOptimizeIsDisable> createState() =>
      _ChekBatteryOptimizeIsDisableState();
}

class _ChekBatteryOptimizeIsDisableState
    extends State<ChekBatteryOptimizeIsDisable> {
  bool isDisable = false;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      checkBatteryPermition();
    } else {
      isDisable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: isDisable
          ? const SizedBox()
          : JBButtonMix(
              padding: const EdgeInsets.all(12),
              title:
                  "لاتعمل خدمة الاذان بشكل صحيح اضغط للسماح بتعطيل تحسين البطارية لتطبيق خزنة السماء",
              backgroundColor: Colors.red,
              icon: const Icon(LucideIcons.alertTriangle),
              onPressed: () {
                checkBatteryPermition();
              },
            ),
    );
  }

  checkBatteryPermition() {
    OptimizeBattery.isIgnoringBatteryOptimizations().then((onValue) async {
      if (onValue) {
        // Igonring Battery Optimization
        setState(() {
          isDisable = true;
        });
      } else {
        // App is under battery optimization

        OptimizeBattery.stopOptimizingBatteryUsage();
      }
    });
  }
}
