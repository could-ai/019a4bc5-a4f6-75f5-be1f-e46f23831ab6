import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:couldai_user_app/providers/auth_provider.dart';
import 'package:couldai_user_app/models/report.dart';
import 'package:couldai_user_app/screens/report_detail_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
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
      photos: ['photo1.jpg'],
      videos: [],
      rating: 4.5,
      feedback: 'گزارش خوبی ارائه شده است.',
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
      videos: ['video1.mp4'],
    ),
  ];

  String _selectedDateFilter = 'همه';
  String _selectedExpertFilter = 'همه';
  String _selectedRegionFilter = 'همه';
  String _selectedCategoryFilter = 'همه';

  List<Report> get _filteredReports {
    return _reports.where((report) {
      if (_selectedDateFilter != 'همه' && !report.date.toString().contains(_selectedDateFilter)) return false;
      if (_selectedExpertFilter != 'همه' && report.region != _selectedExpertFilter) return false;
      if (_selectedRegionFilter != 'همه' && report.region != _selectedRegionFilter) return false;
      if (_selectedCategoryFilter != 'همه' && report.category != _selectedCategoryFilter) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('داشبورد مدیر'),
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
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.grey[100],
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('فیلترها', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: _selectedDateFilter,
                  items: ['همه', 'امروز', 'دیروز', 'هفته گذشته']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedDateFilter = value!),
                ),
                DropdownButton<String>(
                  value: _selectedExpertFilter,
                  items: ['همه', 'شمال', 'جنوب', 'مرکزی']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedExpertFilter = value!),
                ),
                DropdownButton<String>(
                  value: _selectedRegionFilter,
                  items: ['همه', 'شمال', 'جنوب', 'مرکزی']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedRegionFilter = value!),
                ),
                DropdownButton<String>(
                  value: _selectedCategoryFilter,
                  items: ['همه', 'روزانه', 'مشکلات', 'پیشنهاد']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedCategoryFilter = value!),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Mock export
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('گزارش به PDF صادر شد')),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('صدور به PDF'),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Mock export
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('گزارش به Excel صادر شد')),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('صدور به Excel'),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Statistics cards
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('تعداد گزارش‌های امروز', style: Theme.of(context).textTheme.titleMedium),
                                const Text('5', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('بهترین کارشناس هفته', style: Theme.of(context).textTheme.titleMedium),
                                const Text('احمد رضایی', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('میانگین امتیاز گزارش‌ها', style: Theme.of(context).textTheme.titleMedium),
                                const Text('4.2', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Charts
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('گزارش‌ها بر اساس دسته‌بندی', style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 200,
                                  child: PieChart(
                                    PieChartData(
                                      sections: [
                                        PieChartSectionData(
                                          value: 40,
                                          title: 'روزانه',
                                          color: Colors.blue,
                                        ),
                                        PieChartSectionData(
                                          value: 30,
                                          title: 'مشکلات',
                                          color: Colors.red,
                                        ),
                                        PieChartSectionData(
                                          value: 30,
                                          title: 'پیشنهاد',
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('گزارش‌ها در طول زمان', style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 200,
                                  child: BarChart(
                                    BarChartData(
                                      barGroups: [
                                        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5)]),
                                        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 3)]),
                                        BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 8)]),
                                        BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 6)]),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Data table
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('لیست گزارش‌ها', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 16),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('عنوان')),
                                    DataColumn(label: Text('کارشناس')),
                                    DataColumn(label: Text('منطقه')),
                                    DataColumn(label: Text('تاریخ')),
                                    DataColumn(label: Text('وضعیت')),
                                    DataColumn(label: Text('امتیاز')),
                                    DataColumn(label: Text('عملیات')),
                                  ],
                                  rows: _filteredReports.map((report) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(report.title)),
                                        DataCell(Text(report.region)),
                                        DataCell(Text(report.region)),
                                        DataCell(Text(report.date.toPersianDate())),
                                        DataCell(Text(report.status)),
                                        DataCell(Text(report.rating?.toString() ?? '-')),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.visibility),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ReportDetailScreen(report: report),
                                                    ),
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.star),
                                                onPressed: () {
                                                  // Mock rate
                                                  setState(() {
                                                    report.rating = 4.0;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}