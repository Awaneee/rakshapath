import 'package:flutter/material.dart';

class ClientSettings extends StatefulWidget {
  @override
  _ClientSettingsState createState() => _ClientSettingsState();
}

class _ClientSettingsState extends State<ClientSettings> {
  bool _liveTracking = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Icon(Icons.language, color: Color(0xFF0284C7)),
          title: Text('Language', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(_language),
          onTap: () => _showLanguagePicker(context),
        ),
        Divider(),
        SwitchListTile(
          title: Text('Live GPS Tracking', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Allow live location tracking (optional)'),
          value: _liveTracking,
          activeColor: Color(0xFF0284C7),
          onChanged: (val) => setState(() => _liveTracking = val),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info_outline, color: Color(0xFF0284C7)),
          title: Text('App Version'),
          subtitle: Text('1.0.0'),
          onTap: () {},
        ),
        SizedBox(height: 18),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out (demo)')));
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text('Logout', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7)),
        )
      ],
    );
  }

  void _showLanguagePicker(BuildContext context) {
    final languages = [
      'English',
      'Hindi',
      'Bengali',
      'Telugu',
      'Marathi',
      'Tamil',
      'Gujarati',
      'Urdu',
      'Kannada',
      'Malayalam',
      'Oriya'
    ];
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView.builder(
          itemCount: languages.length,
          itemBuilder: (c, i) {
            return RadioListTile<String>(
              title: Text(languages[i]),
              value: languages[i],
              groupValue: _language,
              onChanged: (val) {
                setState(() {
                  _language = val!;
                  Navigator.pop(context);
                });
              },
            );
          },
        );
      },
    );
  }
}
