import 'dart:async';

import 'package:flutter/material.dart';

import 'server_selection.dart'; // server selection screen import

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isConnected = false;

  // Timer variables
  Timer? _timer;
  int _seconds = 0;

  // Default selected server
  Map<String, String> currentServer = {
    "country": "United States",
    "city": "New York",
    "flag": "https://flagcdn.com/w320/us.png",
  };

  /// Start timer
  void _startTimer() {
    _seconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  /// Stop timer
  void _stopTimer() {
    _timer?.cancel();
    _seconds = 0;
  }

  /// Format seconds → HH:MM:SS
  String _formatDuration(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$secs";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    "Secure VPN",
    style: TextStyle(
      fontWeight: FontWeight.bold, // 👈 yahan bold set ho raha hai
      fontSize: 20, // optional, agar size bhi change karna ho
    ),
  ),
  centerTitle: true,
  elevation: 0,
  backgroundColor: Colors.transparent,
),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Status text + Timer
            Column(
              children: [
                Text(
                  isConnected ? "Connected" : "Disconnected",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isConnected ? Colors.greenAccent : Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 10),
                if (isConnected)
                  Text(
                    "Connected time: ${_formatDuration(_seconds)}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w500),
                  )
                else
                  const Text(
                    "Tap the button to connect",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
              ],
            ),

            // Connect Button
            GestureDetector(
              onTap: () {
                setState(() {
                  if (isConnected) {
                    // disconnect
                    isConnected = false;
                    _stopTimer();
                  } else {
                    // connect
                    isConnected = true;
                    _startTimer();
                  }
                });
              },
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isConnected
                        ? [Colors.greenAccent, Colors.green]
                        : [Colors.grey.shade700, Colors.grey.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isConnected
                          ? Colors.greenAccent.withOpacity(0.4)
                          : Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    isConnected ? "DISCONNECT" : "CONNECT",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Server Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(currentServer["flag"]!),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "${currentServer["country"]} - ${currentServer["city"]}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 18),
                    onPressed: () async {
                      final selectedServer = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServerSelectionPage(),
                        ),
                      );

                      if (selectedServer != null) {
                        setState(() {
                          currentServer =
                              Map<String, String>.from(selectedServer);
                        });
                      }
                    },
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
