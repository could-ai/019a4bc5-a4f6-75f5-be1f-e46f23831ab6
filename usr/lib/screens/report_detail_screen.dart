import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/report.dart';

class ReportDetailScreen extends StatefulWidget {
  final Report report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  final _feedbackController = TextEditingController();
  double _rating = 0;

  @override
  void initState() {
    super.initState();
    _rating = widget.report.rating ?? 0;
    _feedbackController.text = widget.report.feedback ?? '';
  }

  void _saveFeedback() {
    setState(() {
      widget.report.rating = _rating;
      widget.report.feedback = _feedbackController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('بازخورد ذخیره شد')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات گزارش'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('لیست گزارش‌ها'),
                ),
                const Text(' > '),
                Text(widget.report.title),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              widget.report.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text('تاریخ: ${widget.report.date.toPersianDate()}'),
            Text('دسته‌بندی: ${widget.report.category}'),
            Text('منطقه: ${widget.report.region}'),
            Text('تگ‌ها: ${widget.report.tags.join(', ')}'),
            Text('وضعیت: ${widget.report.status}'),
            const SizedBox(height: 24),
            Text(
              'توضیحات کامل:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(widget.report.description),
            const SizedBox(height: 24),
            if (widget.report.photos.isNotEmpty) ...[
              Text(
                'عکس‌ها:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: widget.report.photos.map((photo) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.photo),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            if (widget.report.videos.isNotEmpty) ...[
              Text(
                'ویدیوها:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: widget.report.videos.map((video) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.video_file),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            // Admin feedback section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بازخورد مدیر:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              _rating = index + 1.0;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _feedbackController,
                      decoration: const InputDecoration(
                        labelText: 'نظر مدیر',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveFeedback,
                      child: const Text('ذخیره بازخورد'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}