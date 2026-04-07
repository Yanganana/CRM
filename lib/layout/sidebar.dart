import 'package:flutter/material.dart';
import 'package:consultant_crm/theme/app_theme.dart';

class CRMSidebar extends StatelessWidget {
  final int selectedIndex;
  final int selectedModuleIndex; // 0: 营销, 1: 课程, 2: 活动, 3: 顾客
  final Function(int) onItemSelected;
  final Function(int) onModuleSelected;

  const CRMSidebar({
    super.key,
    required this.selectedIndex,
    required this.selectedModuleIndex,
    required this.onItemSelected,
    required this.onModuleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left mini sidebar for modules
        Container(
          width: 72,
          color: const Color(0xFF162033),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildModuleIcon(0, Icons.rocket_launch_outlined, '营销'),
              _buildModuleIcon(1, Icons.school_outlined, '课程'),
              _buildModuleIcon(2, Icons.calendar_month_outlined, '活动'),
              _buildModuleIcon(3, Icons.people_outline, '顾客'),
              const Spacer(),
              _buildModuleIcon(-1, Icons.settings_outlined, '设置'),
              const SizedBox(height: 20),
            ],
          ),
        ),
        // Right expanded sidebar for sub-navigation
        Container(
          width: 200,
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            border: Border(right: BorderSide(color: AppTheme.borderGray, width: 1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModuleTitle(),
              const SizedBox(height: 16),
              if (selectedModuleIndex == 3) ...[
                _buildNavGroup('顾客管理'),
                _SidebarItem(
                  icon: Icons.dashboard_outlined,
                  label: '概览',
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemSelected(0),
                ),
                _SidebarItem(
                  icon: Icons.business_outlined,
                  label: '企业列表',
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemSelected(1),
                ),
                _SidebarItem(
                  icon: Icons.people_outline,
                  label: '学员列表',
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemSelected(2),
                ),
              ] else if (selectedModuleIndex == 0) ...[
                _buildNavGroup('营销模块'),
                _SidebarItem(
                  icon: Icons.pie_chart_outline,
                  label: '概览',
                  isSelected: true,
                  onTap: () {},
                ),
                _SidebarItem(
                  icon: Icons.track_changes,
                  label: '营销计划',
                  isSelected: false,
                  onTap: () {},
                ),
                _SidebarItem(
                  icon: Icons.bar_chart_outlined,
                  label: '营销实绩',
                  isSelected: false,
                  onTap: () {},
                ),
                _SidebarItem(
                  icon: Icons.assignment_outlined,
                  label: '结果汇总',
                  isSelected: false,
                  onTap: () {},
                ),
              ],
              const Spacer(),
              _buildFooterItem(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModuleIcon(int index, IconData icon, String label) {
    final bool isSelected = index == selectedModuleIndex;
    return GestureDetector(
      onTap: () => index != -1 ? onModuleSelected(index) : null,
      child: Container(
        width: 72,
        height: 72,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[600] : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white60,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleTitle() {
    String title = '';
    switch (selectedModuleIndex) {
      case 0: title = '营销'; break;
      case 1: title = '课程'; break;
      case 2: title = '活动'; break;
      case 3: title = '顾客'; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF162033),
        ),
      ),
    );
  }

  Widget _buildNavGroup(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildFooterItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Icon(Icons.settings_outlined, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '系统配置',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ] : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? const Color(0xFF2F6FED) : Colors.grey[600],
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF2F6FED) : Colors.grey[600],
                ),
              ),
              if (isSelected) const Spacer(),
              if (isSelected) const Icon(Icons.chevron_right, size: 14, color: Color(0xFF2F6FED)),
            ],
          ),
        ),
      ),
    );
  }
}
