import 'package:flutter/material.dart';
import 'package:consultant_crm/theme/app_theme.dart';
import 'package:consultant_crm/layout/sidebar.dart';
import 'package:consultant_crm/views/dashboard/dashboard_page.dart';
import 'package:consultant_crm/views/enterprise_list/enterprise_list_page.dart';
import 'package:consultant_crm/views/enterprise_detail/enterprise_detail_page.dart';
import 'package:consultant_crm/views/student_list/student_list_page.dart';
import 'package:consultant_crm/views/student_list/student_list_page_detail.dart';
import 'package:consultant_crm/utils/responsive.dart';

void main() {
  runApp(const CRMApp());
}

class CRMApp extends StatelessWidget {
  const CRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '营销管理系统',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  int _selectedModuleIndex = 3; // Default to Customer (顾客) module
  bool _showEnterpriseDetail = false;
  bool _showStudentDetail = false;

  void _onNavigationChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _showEnterpriseDetail = false;
      _showStudentDetail = false;
    });
    if (Responsive.isMobile(context)) {
      Navigator.pop(context);
    }
  }

  void _onModuleChanged(int index) {
    setState(() {
      _selectedModuleIndex = index;
      _selectedIndex = 0; // Reset sub-navigation when switching modules
      _showEnterpriseDetail = false;
      _showStudentDetail = false;
    });
  }

  void _onEnterpriseDetailRequested() {
    setState(() {
      _showEnterpriseDetail = true;
      _showStudentDetail = false;
    });
  }

  void _onStudentDetailRequested() {
    setState(() {
      _showEnterpriseDetail = false;
      _showStudentDetail = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    final sidebar = CRMSidebar(
      selectedIndex: _selectedIndex,
      selectedModuleIndex: _selectedModuleIndex,
      onItemSelected: _onNavigationChanged,
      onModuleSelected: _onModuleChanged,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              title: Text(
                _selectedModuleIndex == 0 ? "营销" : 
                _selectedModuleIndex == 1 ? "课程" :
                _selectedModuleIndex == 2 ? "活动" : "顾客管理",
                style: const TextStyle(color: Color(0xFF1E293B), fontSize: 18),
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF1E293B)),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            )
          : null,
      drawer: isMobile ? Drawer(child: sidebar) : null,
      body: Row(
        children: [
          if (!isMobile) sidebar,
          Expanded(
            child: Container(
              color: AppTheme.backgroundGray,
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    // Only show customer module content for now if selected
    if (_selectedModuleIndex == 3) {
      if (_showEnterpriseDetail) {
        return EnterpriseDetailPage(
          onBack: () => setState(() => _showEnterpriseDetail = false),
        );
      }
      if (_showStudentDetail) {
        return StudentDetailPage(
          onBack: () => setState(() => _showStudentDetail = false),
        );
      }

      if (_selectedIndex == 0) {
        return const DashboardPage();
      } else if (_selectedIndex == 1) {
        return EnterpriseListPage(
          onDetailRequested: _onEnterpriseDetailRequested,
        );
      } else if (_selectedIndex == 2) {
        return StudentListPage(
          onDetailRequested: _onStudentDetailRequested,
        );
      }
    }

    // Fallback for other modules
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction_outlined, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "模块 $_selectedModuleIndex 正在建设中...",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => _onModuleChanged(3),
            child: const Text("返回顾客管理"),
          ),
        ],
      ),
    );
  }
}
