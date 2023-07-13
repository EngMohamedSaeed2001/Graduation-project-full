class NotificationModel {
  final String title;
  final String subtitle;
  final DateTime date;
  bool opened;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.date,
    this.opened = false,
  });
}