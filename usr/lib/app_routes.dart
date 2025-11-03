import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/login_screen.dart';
import 'package:couldai_user_app/screens/user_dashboard_screen.dart';
import 'package:couldai_user_app/screens/admin_dashboard_screen.dart';
import 'package:couldai_user_app/screens/new_report_screen.dart';
import 'package:couldai_user_app/screens/report_detail_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String userDashboard = '/user-dashboard';
  static const String adminDashboard = '/admin-dashboard';
  static const String newReport = '/new-report';
  static const String reportDetail = '/report-detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      userDashboard: (context) => const UserDashboardScreen(),
      adminDashboard: (context) => const AdminDashboardScreen(),
      newReport: (context) => const NewReportScreen(),
      reportDetail: (context) => const ReportDetailScreen(report: null as Report), // This should be passed via arguments
    };
  }
}