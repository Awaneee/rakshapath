import 'package:flutter/material.dart';
import 'package:rakshapath/l10n/app_localizations.dart';
import '../../../main.dart';

class ClientSettings extends StatefulWidget {
  @override
  _ClientSettingsState createState() => _ClientSettingsState();
}

class _ClientSettingsState extends State<ClientSettings> {
  bool _liveTracking = false;
  late Locale _currentLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentLocale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        backgroundColor: Color(0xFF0284C7),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfileSection(),
              const SizedBox(height: 20),
              _buildSettingsCard(localizations),
              const SizedBox(height: 20),
              _buildLogoutButton(localizations),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Color(0xFFE0F7FA),
          child: Icon(Icons.person, size: 50, color: Color(0xFF0284C7)),
        ),
        SizedBox(height: 10),
        Text(
          'Palak Sharma',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          'palak.sharma@example.com',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildSettingsCard(AppLocalizations localizations) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                localizations.preferences,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0284C7)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language, color: Color(0xFF0284C7)),
              title: Text(localizations.language, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_currentLocale.languageCode == 'hi' ? 'हिंदी' : 'English'),
              onTap: () => _showLanguagePicker(context),
            ),
            const Divider(),
            SwitchListTile(
              title: Text(localizations.liveGpsTracking, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(localizations.allowLiveGpsTracking),
              value: _liveTracking,
              activeColor: Color(0xFF0284C7),
              onChanged: (val) => setState(() => _liveTracking = val),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.info_outline, color: Color(0xFF0284C7)),
              title: Text(localizations.appVersion),
              subtitle: Text('1.0.0'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(AppLocalizations localizations) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out (demo)')));
        Navigator.pushReplacementNamed(context, '/login');
      },
      icon: Icon(Icons.logout, color: Colors.white),
      label: Text(localizations.logout, style: TextStyle(color: Colors.white, fontSize: 16)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    final languages = {
      'English': Locale('en', ''),
      'हिंदी': Locale('hi', ''),
    };

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView.builder(
          itemCount: languages.length,
          itemBuilder: (c, i) {
            final langName = languages.keys.elementAt(i);
            final langLocale = languages.values.elementAt(i);
            return RadioListTile<Locale>(
              title: Text(langName),
              value: langLocale,
              groupValue: _currentLocale,
              activeColor: Color(0xFF0284C7),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _currentLocale = val;
                  });
                  MyApp.setLocale(context, val);
                  Navigator.pop(context);
                }
              },
            );
          },
        );
      },
    );
  }
}
