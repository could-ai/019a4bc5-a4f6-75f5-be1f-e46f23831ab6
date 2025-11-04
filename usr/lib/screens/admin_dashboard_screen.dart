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
    // اضافه کردن گزارش‌های نمونه در خصوص مسائل فرهنگی
    Report(
      id: '3',
      title: 'فعالیت‌های فرهنگی در محله قدیمی',
      description: 'گزارش برگزاری مراسم سنتی نوروز در محله قدیمی شهر، با شرکت بیش از ۲۰۰ نفر از ساکنان محلی. فعالیت‌های شامل رقص محلی، موسیقی سنتی و توزیع شیرینی بود.',
      category: 'فرهنگی',
      region: 'جنوب',
      tags: ['نوروز', 'سنت', 'محلی'],
      date: DateTime.now().subtract(const Duration(days: 0)),
      status: 'تایید شده',
      photos: ['photo2.jpg', 'photo3.jpg'],
      videos: ['video2.mp4'],
      rating: 4.8,
      feedback: 'گزارش بسیار کاملی از فعالیت‌های فرهنگی ارائه شده و تاثیرات مثبت اجتماعی آن برجسته شده.',
    ),
    Report(
      id: '4',
      title: 'مشکلات حفظ میراث فرهنگی',
      description: 'گزارش در مورد تخریب بخشی از بافت تاریخی شهر به دلیل ساخت و ساز غیرمجاز. پیشنهاد بازسازی و حفاظت از بناهای قدیمی ارائه شده.',
      category: 'فرهنگی',
      region: 'مرکزی',
      tags: ['میراث فرهنگی', 'تخریب', 'بازسازی'],
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'در حال بررسی',
      photos: ['photo4.jpg'],
      videos: [],
    ),
    Report(
      id: '5',
      title: 'برگزاری کلاس‌های آموزش زبان محلی',
      description: 'گزارش از برگزاری کلاس‌های هفتگی آموزش زبان و ادبیات پارسی به جوانان منطقه. بیش از ۵۰ شرکت‌کننده و تاثیر مثبت بر هویت فرهنگی.',
      category: 'فرهنگی',
      region: 'شمال',
      tags: ['آموزش', 'زبان پارسی', 'هویت فرهنگی'],
      date: DateTime.now().subtract(const Duration(days: 0)),
      status: 'تایید شده',
      photos: [],
      videos: ['video3.mp4', 'video4.mp4'],
      rating: 4.6,
      feedback: 'ابتکار خوبی برای حفظ زبان و فرهنگ محلی. پیشنهاد گسترش به مناطق دیگر.',
    ),
    Report(
      id: '6',
      title: 'جشنواره غذاهای سنتی',
      description: 'گزارش از جشنواره غذاهای سنتی برگزار شده در پارک مرکزی با حضور آشپزهای محلی. معرفی بیش از ۲۰ نوع غذا سنتی و آموزش تهیه آنها.',
      category: 'فرهنگی',
      region: 'مرکزی',
      tags: ['غذاهای سنتی', 'آموزش', 'جشنواره'],
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'تایید شده',
      photos: ['photo5.jpg', 'photo6.jpg', 'photo7.jpg'],
      videos: ['video5.mp4'],
      rating: 4.9,
      feedback: 'رویداد بسیار موفق که فرهنگ غذایی محلی را زنده نگه داشته.',
    ),
    Report(
      id: '7',
      title: 'مشکلات اجرای برنامه‌های فرهنگی در مدارس',
      description: 'گزارش در مورد کمبود بودجه و تجهیزات برای اجرای برنامه‌های فرهنگی در مدارس منطقه جنوبی. پیشنهاد تخصیص بودجه اضافی.',
      category: 'فرهنگی',
      region: 'جنوب',
      tags: ['آموزش', 'بودجه', 'مدارس'],
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: 'در حال بررسی',
      photos: ['photo8.jpg'],
      videos: [],
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

  // محاسبه آمار بر اساس گزارش‌ها
  int get _todayReportsCount => _reports.where((r) => r.date.day == DateTime.now().day && r.date.month == DateTime.now().month && r.date.year == DateTime.now().year).length;
  double get _averageRating => _reports.where((r) => r.rating != null).map((r) => r.rating!).reduce((a, b) => a + b) / _reports.where((r) => r.rating != null).length;
  String get _bestExpert => 'احمد رضایی'; // ثابت برای نمونه

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
                  items: ['همه', 'روزانه', 'مشکلات', 'فرهنگی', 'پیشنهاد']
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
                                Text('$_todayReportsCount', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
                                Text(_bestExpert, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                                Text(_averageRating.toStringAsFixed(1), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
                                          value: _reports.where((r) => r.category == 'روزانه').length.toDouble(),
                                          title: 'روزانه',
                                          color: Colors.blue,
                                        ),
                                        PieChartSectionData(
                                          value: _reports.where((r) => r.category == 'مشکلات').length.toDouble(),
                                          title: 'مشکلات',
                                          color: Colors.red,
                                        ),
                                        PieChartSectionData(
                                          value: _reports.where((r) => r.category == 'فرهنگی').length.toDouble(),
                                          title: 'فرهنگی',
                                          color: const Color(0xFFC9A227), // Gold color
                                        ),
                                        PieChartSectionData(
                                          value: _reports.where((r) => r.category == 'پیشنهاد').length.toDouble(),
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
                                        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: _reports.where((r) => r.date.day == DateTime.now().subtract(const Duration(days: 6)).day).length.toDouble())]),
                                        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: _reports.where((r) => r.date.day == DateTime.now().subtract(const Duration(days: 5)).day).length.toDouble())]),
                                        BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: _reports.where((r) => r.date.day == DateTime.now().subtract(const Duration(days: 4)).day).length.toDouble())]),
                                        BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: _reports.where((r) => r.date.day == DateTime.now().subtract(const Duration(days: 3)).day).length.toDouble())]),
                                        BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: _reports.where((r) => r.date.day == DateTime.now().subtract(const Duration(days: 2)).day).length.toDouble())]),
                                        BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: _reports.where((r) => r.date.day == DateTime.now().subtract(const Duration(days: 1)).day).length.toDouble())]),
                                        BarChartGroupData(x: 7, barRods: [BarChartRodData(toY: _todayReportsCount.toDouble())]),
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