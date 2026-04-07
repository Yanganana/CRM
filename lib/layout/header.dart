import 'package:flutter/material.dart';
import 'package:consultant_crm/theme/app_theme.dart';
import 'package:consultant_crm/utils/responsive.dart';

class CRMHeader extends StatelessWidget implements PreferredSizeWidget {
  const CRMHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: AppTheme.headerDark,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildLogo(),
          Expanded(
            child: Center(
              child: !isMobile ? _buildTabs() : const SizedBox.shrink(),
            ),
          ),
          const SizedBox(width: 120), // Placeholder to keep center balanced
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [Color(0xFF2F6FED), Color(0xFF1E3A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.connect_without_contact,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          '营销管理系统',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return const Row(
      children: [
        _HeaderTab(label: '营销', isActive: false),
        _HeaderTab(label: '课程', isActive: false),
        _HeaderTab(label: '活动', isActive: false),
        _HeaderTab(label: '顾客', isActive: true),
      ],
    );
  }
}

class _HeaderTab extends StatelessWidget {
  final String label;
  final bool isActive;

  const _HeaderTab({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.tabHighlight : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
