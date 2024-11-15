import 'package:flutter/material.dart';
import 'package:frontend/widgets/hostels_card.dart';

class HostelScreen extends StatelessWidget {
  const HostelScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostels"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            HostelsCard(
              title: "Boy's Hostel",
              type: "boys",
            ),
            SizedBox(
              height: 20,
            ),
            HostelsCard(
              title: "Girl's Hostel",
              type: "girls",
            ),
          ],
        ),
      ),
    );
  }
}
