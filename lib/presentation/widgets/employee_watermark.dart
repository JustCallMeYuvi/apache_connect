import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeWatermark extends StatelessWidget {
  final String employeeName;
  final String employeeNo;
  final bool isDarkMode;

  const EmployeeWatermark({
    super.key,
    required this.employeeName,
    required this.employeeNo,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final name =
        employeeName.trim().isEmpty ? 'Unknown Employee' : employeeName.trim();

    final number = employeeNo.trim().isEmpty ? 'Unknown ID' : employeeNo.trim();

    final currentDateTime =
        DateFormat('yyyy/MM/dd hh:mm a').format(DateTime.now());

    final isDark = isDarkMode;

    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ClipRect(
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  for (double y = -60;
                      y < constraints.maxHeight + 120;
                      y += 170)
                    for (double x = -100;
                        x < constraints.maxWidth + 350;
                        x += 320)
                      Positioned(
                        left: x,
                        top: y,
                        child: Transform.rotate(
                          angle: -0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$name · $number',
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.07)
                                      : Colors.red.shade700
                                          .withValues(alpha: 0.12),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              Text(
                                currentDateTime,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.07)
                                      : Colors.red.shade700
                                          .withValues(alpha: 0.12),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
