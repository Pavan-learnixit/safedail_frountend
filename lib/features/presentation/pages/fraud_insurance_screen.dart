import 'package:flutter/material.dart';

class FraudInsuranceScreen extends StatelessWidget {
  const FraudInsuranceScreen({Key? key}) : super(key: key);

  final List<Map<String,String>> reports = const [
    {"name":"Fake Bank Agent","type":"Bank Fraud","status":"Pending"},
    {"name":"Phishing SMS","type":"Phishing","status":"Investigating"},
    {"name":"Loan Shark","type":"Loan Fraud","status":"Action Taken"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fraud issuances')),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: reports.length,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = reports[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(item['name']![0])),
              title: Text(item['name']!),
              subtitle: Text(item['type']!),
              trailing: Chip(label: Text(item['status']!)),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}