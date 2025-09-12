import 'package:flutter/material.dart';
import 'package:rakshapath/l10n/app_localizations.dart';
import 'package:rakshapath/services/storageService.dart';

class ClientProfile extends StatefulWidget {
  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  late Locale _currentLocale;
  String? _username; // <- local state variable

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final name = await storage.readName();
    if (mounted) {
      setState(() {
        _username = name;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentLocale = Localizations.localeOf(context);
  }

  final storage = SecureStorageService();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          _buildDigitalIDCard(),
          const SizedBox(height: 10),
          _buildTripItineraryCard(),
          const SizedBox(height: 10),
          _buildEmergencyContactsCard(),
          const SizedBox(height: 20),
          _buildSettingsCard(localizations),
          const SizedBox(height: 20),
          _buildLogoutButton(localizations),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
            radius: 36,
            backgroundColor: Color(0xFF0284C7).withOpacity(0.1),
            child: Icon(Icons.person, size: 36, color: Color(0xFF0284C7))),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$_username',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Basic account • Bali, Indonesia',
                  style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7)),
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  Widget _buildDigitalIDCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(Icons.qr_code, color: Color(0xFF0284C7)),
        title: Text('Digital ID'),
        subtitle: Text('View or share your tourist ID (QR/NFC)'),
        trailing: Icon(Icons.share, color: Color(0xFF0284C7)),
        onTap: () => _showComingSoon(context),
      ),
    );
  }

  Widget _buildTripItineraryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(Icons.map_outlined, color: Color(0xFF0284C7)),
        title: Text('Trip Itinerary'),
        subtitle: Text('Upload or view your planned travel itinerary'),
        trailing: Icon(Icons.upload_file, color: Color(0xFF0284C7)),
        onTap: () => _showComingSoon(context),
      ),
    );
  }

  Widget _buildEmergencyContactsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(Icons.contacts, color: Color(0xFF0284C7)),
        title: Text('Emergency Contacts'),
        subtitle: Text('Edit your emergency contact numbers'),
        trailing: Icon(Icons.edit, color: Color(0xFF0284C7)),
        onTap: () => _showComingSoon(context),
      ),
    );
  }

  Widget _buildSettingsCard(AppLocalizations localizations) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                localizations.preferences,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0284C7)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language, color: Color(0xFF0284C7)),
              title: Text(localizations.language,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  _currentLocale.languageCode == 'hi' ? 'हिंदी' : 'English'),
              onTap: () => _showLanguagePicker(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(AppLocalizations localizations) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Add logout logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0284C7),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          localizations.logout,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    // Add language picker logic here
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Feature coming soon!')));
  }
}
