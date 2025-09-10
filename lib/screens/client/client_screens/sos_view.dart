import 'package:flutter/material.dart';

class ClientSOSView extends StatelessWidget {
  const ClientSOSView({super.key});

  void _sendSOS(BuildContext context) {
    // TODO: Hook this into your backend / API / SMS / call logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("🚨 SOS Sent! Help is on the way."),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.emergency,
              color: Colors.red,
              size: 100,
            ),
            const SizedBox(height: 30),
            const Text(
              "Emergency SOS",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Press the button below to immediately send an SOS alert.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4B5563),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(40),
                elevation: 6,
              ),
              onPressed: () => _sendSOS(context),
              child: const Icon(
                Icons.sos,
                size: 60,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
