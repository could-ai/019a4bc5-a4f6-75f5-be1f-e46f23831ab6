import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/auth_provider.dart';
import 'package:couldai_user_app/screens/new_report_screen.dart';
import 'package:couldai_user_app/models/report.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  final List<Report> _reports = [
    Report(
      id: '1',
      title: 'گزارش روزانه منطقه شمال',
      description: 'گزارش فعالیت‌های روزانه در منطقه شمال شهر',
      category: 'روزانه',
      region: 'شمال',
      tags: ['فعالیت', 'گزارش'],
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'تایید شده',
      photos: [],
      videos: [],
    ),
    Report(
      id: '2',
      title: 'مشکلات زیرساختی',
      description: 'گزارش مشکلات زیرساختی در منطقه مرکزی',
      category: 'مشکلات',
      region: 'مرکزی',
      tags: ['زیرساخت', 'مشکل'],
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'در حال بررسی',
      photos: [],
      videos: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('داشبورد کارشناس محلی'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'خوش آمدید، ${authProvider.userName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewReportScreen()),
                ).then((_) => setState(() {}));
              },
              icon: const Icon(Icons.add),
              label: const Text('ثبت گزارش جدید'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _reports.length,
                itemBuilder: (context, index) {
                  final report = _reports[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(report.title),
                      subtitle: Text(
                        '${report.date.toPersianDate()} - ${report.status}',
                      ),
                      leading: const Icon(Icons.report),
                      trailing: report.photos.isNotEmpty
                          ? const Icon(Icons.photo)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewReportScreen()),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}