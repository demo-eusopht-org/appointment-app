
import 'package:appointment_management/src/views/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy notification data for demonstration
  List<String> notifications = [
    "Notification 1",
    "Notification 2",
    "Notification 3",
    "Notification 4",
    "Notification 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Notifications",
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                notifications[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
