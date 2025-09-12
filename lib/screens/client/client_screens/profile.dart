import 'package:flutter/material.dart';

class ClientProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _profileHeader(),
        SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: Icon(Icons.qr_code, color: Color(0xFF0284C7)),
            title: Text('Digital ID'),
            subtitle: Text('View or share your tourist ID (QR/NFC)'),
            trailing: Icon(Icons.share, color: Color(0xFF0284C7)),
            onTap: () => _showComingSoon(context),
          ),
        ),
        SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: Icon(Icons.map_outlined, color: Color(0xFF0284C7)),
            title: Text('Trip Itinerary'),
            subtitle: Text('Upload or view your planned travel itinerary'),
            trailing: Icon(Icons.upload_file, color: Color(0xFF0284C7)),
            onTap: () => _showComingSoon(context),
          ),
        ),
        SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: Icon(Icons.contacts, color: Color(0xFF0284C7)),
            title: Text('Emergency Contacts'),
            subtitle: Text('Edit your emergency contact numbers'),
            trailing: Icon(Icons.edit, color: Color(0xFF0284C7)),
            onTap: () => _showComingSoon(context),
          ),
        ),
      ],
    );
  }

  Widget _profileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 36, 
          backgroundColor: Color(0xFF0284C7).withValues(alpha:0.1), 
          child: Icon(Icons.person, size: 36, color: Color(0xFF0284C7))
        ),
        SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Annie January', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Basic account • Bali, Indonesia', style: TextStyle(color: Colors.black54)),
        ]),
        Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7)),
          child: Text('Edit', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feature coming soon!')));
  }
}
