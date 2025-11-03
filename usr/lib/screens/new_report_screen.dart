import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/report.dart';

class NewReportScreen extends StatefulWidget {
  const NewReportScreen({super.key});

  @override
  State<NewReportScreen> createState() => _NewReportScreenState();
}

class _NewReportScreenState extends State<NewReportScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _regionController = TextEditingController();
  final _tagsController = TextEditingController();

  List<String> _photos = [];
  List<String> _videos = [];

  void _submitReport() {
    final report = Report(
      id: DateTime.now().toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      category: _categoryController.text,
      region: _regionController.text,
      tags: _tagsController.text.split(',').map((e) => e.trim()).toList(),
      date: DateTime.now(),
      status: 'در حال بررسی',
      photos: _photos,
      videos: _videos,
    );
    // In real app, save to database
    Navigator.pop(context, report);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت گزارش جدید'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'عنوان گزارش',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'دسته‌بندی',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _regionController,
                    decoration: const InputDecoration(
                      labelText: 'منطقه',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      labelText: 'تگ‌ها (با کاما جدا کنید)',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'توضیحات',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Mock photo upload
                      setState(() {
                        _photos.add('photo${_photos.length + 1}.jpg');
                      });
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text('آپلود عکس'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Mock video upload
                      setState(() {
                        _videos.add('video${_videos.length + 1}.mp4');
                      });
                    },
                    icon: const Icon(Icons.video_file),
                    label: const Text('آپلود ویدیو'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ..._photos.map((photo) => Chip(label: Text(photo))),
                ..._videos.map((video) => Chip(label: Text(video))),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitReport,
                    child: const Text('ثبت گزارش'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('لغو'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _regionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}