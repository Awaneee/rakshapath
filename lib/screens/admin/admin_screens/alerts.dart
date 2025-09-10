import 'package:flutter/material.dart';

class AdminAlertPanel extends StatefulWidget {
  @override
  _AdminAlertPanelState createState() => _AdminAlertPanelState();
}

class _AdminAlertPanelState extends State<AdminAlertPanel> {
  final List<Map<String, dynamic>> alerts = [
    {'id': 'A001', 'type': 'Panic', 'user': 'Annie', 'time': '2m ago', 'status': 'new'},
    {'id': 'A002', 'type': 'Geo-fence', 'user': 'Tukul', 'time': '10m ago', 'status': 'in_progress'},
    {'id': 'A003', 'type': 'AI Anomaly', 'user': 'Guest123', 'time': '28m ago', 'status': 'resolved'},
  ];

  void _updateStatus(int idx, String status) {
    setState(() {
      alerts[idx]['status'] = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF06B6D4), Color(0xFF0284C7)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.report_problem, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alert Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${alerts.length} active alerts',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        
        // Alerts list
        ...alerts.asMap().entries.map((entry) {
          final i = entry.key;
          final a = entry.value;
          return _buildAlertCard(a, i);
        }).toList(),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> a, int i) {
    Color statusColor = a['status'] == 'new' ? Colors.redAccent : 
                       a['status'] == 'in_progress' ? Colors.orangeAccent : Colors.greenAccent;
    
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showAlertDetails(a, i),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.report_problem, color: statusColor, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          a['type'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            a['status'].toUpperCase(),
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'User: ${a['user']} • ${a['time']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ID: ${a['id']}',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (val) => _updateStatus(i, val),
                icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'new', child: Text('Mark New')),
                  PopupMenuItem(value: 'in_progress', child: Text('In Progress')),
                  PopupMenuItem(value: 'resolved', child: Text('Resolve')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDetails(Map<String, dynamic> a, int i) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.report_problem, color: Color(0xFF0284C7)),
            SizedBox(width: 8),
            Text('Alert Details'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow('Type', a['type']),
            _detailRow('User', a['user']),
            _detailRow('Status', a['status']),
            _detailRow('Time', a['time']),
            _detailRow('ID', a['id']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateStatus(i, 'in_progress');
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0284C7),
            ),
            child: Text('Take Action', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
