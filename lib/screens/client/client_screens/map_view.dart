import 'package:flutter/material.dart';

class ClientMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder map UI
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 420,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.map_outlined, color: Color(0xFF0284C7)),
                          SizedBox(width: 8),
                          Text('Map (placeholder)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF0284C7).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFF0284C7).withOpacity(0.2)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.map_outlined, size: 80, color: Color(0xFF0284C7).withOpacity(0.6)),
                              SizedBox(height: 12),
                              Text('Interactive Map', style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.w600)),
                              SizedBox(height: 4),
                              Text('Live location tracking', style: TextStyle(color: Color(0xFF0284C7).withOpacity(0.7), fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _mapStat(Icons.warning, 'Geo-fence\nBreaches', '2'),
                          _mapStat(Icons.local_police, 'Nearby\nPolice', '5'),
                          _mapStat(Icons.local_hospital, 'Hospitals', '3'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Text('Live location • Safe/danger zones highlighted • Nearby services')
          ],
        ),
      ),
    );
  }

  Widget _mapStat(IconData icon, String title, String value) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: Color(0xFF0284C7).withOpacity(0.12), child: Icon(icon, color: Color(0xFF0284C7))),
        SizedBox(height: 8),
        Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        SizedBox(height: 6),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
      ],
    );
  }
}
