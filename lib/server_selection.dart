import 'package:flutter/material.dart';

class ServerSelectionPage extends StatelessWidget {
  ServerSelectionPage({super.key});

  // Dummy server data
  final List<Map<String, dynamic>> servers = [
    {
      "country": "United States",
      "city": "New York",
      "flag": "https://flagcdn.com/w320/us.png",
      "ping": 120,
    },
    {
      "country": "United Kingdom",
      "city": "London",
      "flag": "https://flagcdn.com/w320/gb.png",
      "ping": 80,
    },
    {
      "country": "Germany",
      "city": "Berlin",
      "flag": "https://flagcdn.com/w320/de.png",
      "ping": 95,
    },
    {
      "country": "India",
      "city": "Mumbai",
      "flag": "https://flagcdn.com/w320/in.png",
      "ping": 200,
    },
    {
      "country": "Singapore",
      "city": "Singapore",
      "flag": "https://flagcdn.com/w320/sg.png",
      "ping": 60,
    },
  ];

  // Ping ke basis par status
  String getStatus(int ping) {
    if (ping < 80) return "Fast";
    if (ping < 150) return "Normal";
    return "Slow";
  }

  Color getStatusColor(int ping) {
    if (ping < 80) return Colors.greenAccent;
    if (ping < 150) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Server"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: servers.length,
        itemBuilder: (context, index) {
          final server = servers[index];
          final ping = server["ping"] as int;

          return Card(
            color: const Color(0xFF2C2C2E),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(server["flag"]),
                radius: 22,
              ),
              title: Text(
                "${server["country"]} - ${server["city"]}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
              subtitle: Row(
                children: [
                  Icon(Icons.network_ping, size: 16, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    "$ping ms",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.circle,
                      size: 10, color: getStatusColor(ping)), // Status dot
                  const SizedBox(width: 4),
                  Text(
                    getStatus(ping),
                    style: TextStyle(
                        fontSize: 14, color: getStatusColor(ping)),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context, {
                  "country": server["country"],
                  "city": server["city"],
                  "flag": server["flag"],
                });
              },
            ),
          );
        },
      ),
    );
  }
}
