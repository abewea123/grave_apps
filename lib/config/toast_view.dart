import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';

import 'haptic_feedback.dart';

class ToastView {
  static error(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon}) {
    AchievementView(
      context,
      title: title,
      subTitle: subtitle,
      textStyleTitle: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
      textStyleSubTitle: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.error,
      ),
      color: Theme.of(context).colorScheme.errorContainer,
      duration: subtitle.length < 30
          ? const Duration(seconds: 2)
          : const Duration(seconds: 8),
      isCircle: true,
    ).show();
    Haptic.feedbackError();
  }

  static success(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon}) {
    AchievementView(
      context,
      title: title,
      subTitle: subtitle,
      textStyleTitle: TextStyle(
        color: Colors.green.shade800,
      ),
      textStyleSubTitle: TextStyle(
        color: Colors.green.shade800,
      ),
      icon: Icon(
        icon,
        color: Colors.green.shade800,
      ),
      color: Colors.green.shade100,
      duration: title.length < 30 || subtitle.length < 30
          ? const Duration(seconds: 2)
          : const Duration(seconds: 8),
      isCircle: true,
    ).show();
    Haptic.feedbackSuccess();
  }
}
