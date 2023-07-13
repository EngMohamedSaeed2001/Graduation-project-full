import 'package:flutter/material.dart';

import '../models/response/notification_model.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModel notificationModel;
  const NotificationItem({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.notificationModel.opened) {
          setState(() {
            widget.notificationModel.opened = true ;
          });
        }
      },
      child: Container(

        decoration: BoxDecoration(
          color: widget.notificationModel.opened ? Colors.white : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (widget.notificationModel.opened)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.notificationModel.opened ? Icons.mail_outline : Icons.mail,
              color: widget.notificationModel.opened ? Colors.grey : Colors.blue,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notificationModel.title,
                    style: widget.notificationModel.opened
                        ? const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                        : const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.notificationModel.subtitle,
                    style: widget.notificationModel.opened
                        ? const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )
                        : const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.notificationModel.date.toString(),
                    style: widget.notificationModel.opened
                        ? const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    )
                        : const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}