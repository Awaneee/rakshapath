import 'package:flutter/material.dart';

// --- NEW: Data model for a risk zone ---
enum RiskLevel { low, medium, high }

class RiskZone {
  final String id;
  final String title;
  final RiskLevel level;
  final Offset position; // Position on the map image (from top-left)

  const RiskZone({
    required this.id,
    required this.title,
    required this.level,
    required this.position,
  });
}

// --- Converted to StatefulWidget to handle filters ---
class ClientMapView extends StatefulWidget {
  const ClientMapView({super.key});

  @override
  State<ClientMapView> createState() => _ClientMapViewState();
}

class _ClientMapViewState extends State<ClientMapView> {
  // --- NEW: Sample data for risk zones ---
  final List<RiskZone> _riskZones = [
    const RiskZone(
        id: '1',
        title: 'High Theft Area',
        level: RiskLevel.high,
        position: Offset(120, 150)),
    const RiskZone(
        id: '2',
        title: 'Frequent Accidents',
        level: RiskLevel.medium,
        position: Offset(250, 220)),
    const RiskZone(
        id: '3',
        title: 'Protest Zone',
        level: RiskLevel.medium,
        position: Offset(80, 280)),
    const RiskZone(
        id: '4',
        title: 'Reported Vandalism',
        level: RiskLevel.low,
        position: Offset(200, 80)),
  ];

  // --- NEW: State for managing active filters ---
  final Set<RiskLevel> _activeFilters = {
    RiskLevel.high,
    RiskLevel.medium,
    RiskLevel.low
  };

  // --- NEW: Helper to get color based on risk level ---
  Color _getColorForRisk(RiskLevel level) {
    switch (level) {
      case RiskLevel.high:
        return Colors.red.withOpacity(0.7);
      case RiskLevel.medium:
        return Colors.orange.withOpacity(0.7);
      case RiskLevel.low:
        return Colors.green.withOpacity(0.7);
    }
  }

  // --- NEW: Helper to toggle filters ---
  void _toggleFilter(RiskLevel level) {
    setState(() {
      if (_activeFilters.contains(level)) {
        _activeFilters.remove(level);
      } else {
        _activeFilters.add(level);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- NEW: Filtered list of zones to display ---
    final displayedZones = _riskZones
        .where((zone) => _activeFilters.contains(zone.level))
        .toList();

    return SingleChildScrollView(
      // Added to prevent overflow on smaller screens
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              clipBehavior:
                  Clip.antiAlias, // Ensures content respects the border radius
              child: Column(
                children: [
                  // --- NEW: Stack to overlay risk zones on the map ---
                  Stack(
                    children: [
                      // Base Map Image
                      Image.asset(
                        'assets/map2.png',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // Risk Zone Indicators
                      ...displayedZones.map((zone) {
                        return Positioned(
                          left: zone.position.dx,
                          top: zone.position.dy,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Info: ${zone.title}'),
                                  backgroundColor: _getColorForRisk(zone.level),
                                ),
                              );
                            },
                            child: Tooltip(
                              // Shows title on long-press/hover
                              message: zone.title,
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: _getColorForRisk(zone.level),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      // --- NEW: Map Legend ---
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: _buildLegend(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _mapStat(Icons.warning_amber_rounded, 'Breaches', '2'),
                        _mapStat(Icons.local_police, 'Police Station', '5'),
                        _mapStat(Icons.local_hospital, 'Hospitals', '3'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // --- NEW: Filter Chips Section ---
            const Text('Filter Risk Zones',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              // Use Wrap to handle different screen sizes gracefully
              spacing: 8.0,
              children: [
                FilterChip(
                  label: const Text(
                    'High',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  selected: _activeFilters.contains(RiskLevel.high),
                  onSelected: (_) => _toggleFilter(RiskLevel.high),
                  selectedColor: Colors.red.withOpacity(0.3),
                  checkmarkColor: Colors.red,
                ),
                FilterChip(
                  label: const Text(
                    'Medium',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  selected: _activeFilters.contains(RiskLevel.medium),
                  onSelected: (_) => _toggleFilter(RiskLevel.medium),
                  selectedColor: Colors.orange.withOpacity(0.3),
                  checkmarkColor: Colors.orange,
                ),
                FilterChip(
                  label: const Text(
                    'Low',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  selected: _activeFilters.contains(RiskLevel.low),
                  onSelected: (_) => _toggleFilter(RiskLevel.low),
                  selectedColor: Colors.green.withOpacity(0.3),
                  checkmarkColor: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- NEW: Legend Widget ---
  Widget _buildLegend() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _legendItem(Colors.red, 'High Risk'),
            const SizedBox(height: 4),
            _legendItem(Colors.orange, 'Medium Risk'),
            const SizedBox(height: 4),
            _legendItem(Colors.green, 'Low Risk'),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(height: 10, width: 10, color: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 10, color: Colors.black87)),
      ],
    );
  }

  // Helper widget for stats below the map (from your original code)
  Widget _mapStat(IconData icon, String title, String value) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFF0284C7).withOpacity(0.12),
          child: Icon(icon, color: const Color(0xFF0284C7)),
        ),
        const SizedBox(height: 8),
        Text(title,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFF0284C7)),
        ),
      ],
    );
  }
}
