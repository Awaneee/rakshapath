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
    // Replaced ListView with a Padding widget containing a Column.
    // This preserves the padding and uses a non-scrolling layout.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.language, color: Color(0xFF0284C7)),
            title:
                Text('Language', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(_language),
            onTap: () => _showLanguagePicker(context),
          ),
          const Divider(),
          SwitchListTile(
            title: Text('Live GPS Tracking',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Allow live location tracking (optional)'),
            value: _liveTracking,
            activeColor: Color(0xFF0284C7),
            // Use contentPadding to align with ListTile if needed
            contentPadding: EdgeInsets.zero,
            onChanged: (val) => setState(() => _liveTracking = val),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.info_outline, color: Color(0xFF0284C7)),
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
            onTap: () {},
          ),
          // Spacer pushes the following widgets to the bottom of the Column.
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Logged out (demo)')));
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0284C7),
              minimumSize: const Size(double.infinity, 48), // Make button wider
            ),
          )
        ],
      ),
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
        // This part remains the same, as ListView is appropriate here.
        return ListView.builder(
          itemCount: languages.length,
          itemBuilder: (c, i) {
            return RadioListTile<String>(
              title: Text(languages[i]),
              value: languages[i],
              groupValue: _language,
              activeColor: Color(0xFF0284C7),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _language = val;
                    Navigator.pop(context);
                  });
                }
              },
            );
          },
        );
      },
    );
  }
}
