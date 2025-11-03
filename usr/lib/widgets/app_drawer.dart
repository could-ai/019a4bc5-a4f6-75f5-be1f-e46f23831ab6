import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1A73E8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'سامانه گزارش‌های میدانی',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'به سفارش حجت‌الاسلام فاضلی',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'خوش آمدید، ${authProvider.userName}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('داشبورد'),
            onTap: () {
              Navigator.pop(context);
              // Already on dashboard
            },
          ),
          if (authProvider.isAdmin) ...[
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('آمار و تحلیل'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to analytics if separate screen
              },
            ),
          ] else ...[
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('ثبت گزارش جدید'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/new-report');
              },
            ),
          ],
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('خروج'),
            onTap: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}