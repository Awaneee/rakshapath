import 'package:flutter/material.dart';

class ClientHomeDashboard extends StatelessWidget {
  final List<Map<String, String>> recommendations = [
    {
      'title': 'Goa Beach',
      'subtitle': 'North Goa, India',
      'img': 'assets/beach.jpg',
      'price': 'Free'
    },
    {
      'title': 'Himalayan Trek',
      'subtitle': 'Himachal Pradesh, India',
      'img': 'assets/mountain.jpg',
      'price': '₹5000/Trip'
    },
    {
      'title': 'Golden Temple',
      'subtitle': 'Amritsar, Punjab',
      'img': 'assets/temple.jpg',
      'price': 'Entry ₹50'
    }
  ];

  void _panicAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Panic Button Pressed! Authorities notified.')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Header banner matching theme
        Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF06B6D4), Color(0xFF0284C7)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Subtle overlay for better text contrast
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.flight_takeoff, color: Colors.white, size: 28),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Plan safer trips', 
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 18, 
                              fontWeight: FontWeight.w800,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Live safety insights and nearby help', 
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.95),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _overviewCard(
                title: 'Safety Score',
                subtitle: 'Based on travel patterns & alerts',
                trailing: Text('85%',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F382F))),
                icon: Icons.shield_outlined,
                color: Color(0xFF2F382F),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _overviewCard(
                title: 'Nearby Services',
                subtitle: 'Police • Hospital',
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
                icon: Icons.room_service_outlined,
                color: Colors.orangeAccent,
              ),
            )
          ],
        ),
        SizedBox(height: 18),
        Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Icon(Icons.warning_amber_rounded,
                color: Colors.redAccent, size: 36),
            title: Text('Panic Button',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
                'Press in emergency to alert police and emergency contacts'),
            trailing: ElevatedButton(
              onPressed: () => _panicAction(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0284C7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('SOS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ),
        SizedBox(height: 18),
        Text('Popular near you 🔥',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ...recommendations.map((r) => _placeCard(r, context)).toList(),
        SizedBox(height: 18),
        Text('Quick SOS Contacts',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _contactCard('Local Police', '100', Icons.local_police),
        SizedBox(height: 8),
        _contactCard('Ambulance', '102', Icons.local_hospital),
      ],
    );
  }

  Widget _overviewCard(
      {required String title,
      required String subtitle,
      required Widget trailing,
      required IconData icon,
      required Color color}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: Color(0xFF0284C7).withOpacity(0.12),
                child: Icon(icon, color: Color(0xFF0284C7))),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(subtitle,
                        style: TextStyle(color: Colors.black54, fontSize: 12)),
                  ]),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _placeCard(Map<String, String> r, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          // show detail bottom sheet for demo
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (_) => _placeDetailSheet(r),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
              child: Container(
                width: 120,
                height: 90,
                color: Colors.grey[200],
                child: Image.asset(r['img'] ?? 'assets/sample1.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(r['subtitle']!,
                        style: TextStyle(color: Colors.black54, fontSize: 12)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text('14km'),
                          backgroundColor: Color(0xFF0284C7).withOpacity(0.1),
                          shape: StadiumBorder(),
                        ),
                        Text(r['price']!,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _placeDetailSheet(Map<String, String> r) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Wrap(children: [
        Text(r['title']!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Image.asset(r['img']!,
            height: 140, width: double.infinity, fit: BoxFit.cover),
        SizedBox(height: 10),
        Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text(
            'This is a dummy description of the place. Recommend safe hours to visit and tips for tourists.'),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7)),
          child: Center(child: Text('Book / Save', style: TextStyle(color: Colors.white))),
        )
      ]),
    );
  }

  Widget _contactCard(String name, String number, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Color(0xFF0284C7).withOpacity(0.12),
            child: Icon(icon, color: Color(0xFF0284C7))),
        title: Text(name),
        subtitle: Text(number),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7)),
          child: Text('Call', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
