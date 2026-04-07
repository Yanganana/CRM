import 'package:flutter/material.dart';
import 'package:consultant_crm/utils/responsive.dart';

class StudentListPage extends StatefulWidget {
  final VoidCallback onDetailRequested;

  const StudentListPage({super.key, required this.onDetailRequested});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  bool _showAdvancedFilter = false;

  final List<Map<String, String>> _mockStudents = [
    {'name': '金明', 'gender': '男', 'phone': '138****8888', 'company': '赢家时尚控股有限公司', 'position': '总经理', 'course': '理念经营-56期', 'staff': '祝菲菲'},
    {'name': '张伟', 'gender': '男', 'phone': '139****1234', 'company': '华为技术有限公司', 'position': '研发总监', 'course': '组织治理-12期', 'staff': '陈大文'},
    {'name': '李娜', 'gender': '女', 'phone': '136****5678', 'company': '招商银行', 'position': '分行行长', 'course': '战略落地-08期', 'staff': '李小宝'},
    {'name': '王芳', 'gender': '女', 'phone': '137****9012', 'company': '万科企业', 'position': '区域VP', 'course': '理念经营-55期', 'staff': '祝菲菲'},
    {'name': '赵强', 'gender': '男', 'phone': '135****3456', 'company': '腾讯控股', 'position': '产品负责人', 'course': '数字化转型-03期', 'staff': '王小虎'},
    {'name': '孙健', 'gender': '男', 'phone': '131****7890', 'company': '比亚迪', 'position': '制造总监', 'course': '精益生产-22期', 'staff': '陈大文'},
    {'name': '周敏', 'gender': '女', 'phone': '132****4567', 'company': '大疆创新', 'position': '硬件专家', 'course': '创新管理-05期', 'staff': '李小宝'},
    {'name': '吴杰', 'gender': '男', 'phone': '133****2345', 'company': '顺丰控股', 'position': '运营经理', 'course': '物流管理-10期', 'staff': '祝菲菲'},
    {'name': '陈磊', 'gender': '男', 'phone': '134****6789', 'company': '阿里巴巴', 'position': '资深专员', 'course': '数据分析-15期', 'staff': '王小虎'},
    {'name': '林青', 'gender': '女', 'phone': '130****9012', 'company': '美团', 'position': '市场主管', 'course': '运营实战-06期', 'staff': '祝菲菲'},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '学员列表',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement add student logic
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  '新增学员',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6FED),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildActionPanel(),
          if (_showAdvancedFilter) ...[
            const SizedBox(height: 16),
            _buildAdvancedFilterGrid(),
          ],
          const SizedBox(height: 24),
          Expanded(child: _buildStudentTable()),
        ],
      ),
    );
  }

  Widget _buildActionPanel() {
    final bool isMobile = Responsive.isMobile(context);
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          // White Search Icon Button inside the bar
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.search, size: 20, color: Color(0xFF2F6FED)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索姓名、手机号或企业名称...',
                hintStyle: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(
            height: 24,
            width: 1,
            color: const Color(0xFFE2E8F0),
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          IconButton(
            onPressed: () => setState(() => _showAdvancedFilter = !_showAdvancedFilter),
            icon: Icon(
              _showAdvancedFilter ? Icons.filter_list_off : Icons.filter_list,
              size: 20,
              color: const Color(0xFF2F6FED),
            ),
            tooltip: '高级筛选',
          ),
          if (!isMobile)
            TextButton(
              onPressed: () => setState(() => _showAdvancedFilter = !_showAdvancedFilter),
              child: Text(
                _showAdvancedFilter ? '详细筛选' : '高级筛选',
                style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildAdvancedFilterGrid() {
    final bool isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 32,
            runSpacing: isMobile ? 12 : 20,
            children: [
              _buildFilterItem('学员姓名:', '请输入姓名', isInput: true),
              _buildFilterItem('所属企业:', '全部企业'),
              _buildFilterItem('课程系列:', '全部系列'),
              _buildFilterItem('期数:', '全部期数'),
              _buildFilterItem('性别:', '全部性别'),
              _buildFilterItem('跟进人员:', '全部人员'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6FED),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text('执行筛选', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => setState(() => _showAdvancedFilter = false),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                child: const Text('重置条件', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterItem(String label, String hint, {bool isInput = false}) {
    return SizedBox(
      width: 260,
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)))),
          Expanded(
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(hint, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)))),
                  if (!isInput) const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF94A3B8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildStudentTable() {
    final bool isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _mockStudents.length,
              itemBuilder: (context, index) {
                final s = _mockStudents[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(s['name']!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B))),
                                const SizedBox(width: 8),
                                Text(s['gender']!,
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xFF64748B))),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(s['company']!,
                                style: const TextStyle(
                                    fontSize: 13, color: Color(0xFF475569)),
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text(s['course']!,
                                style: const TextStyle(
                                    fontSize: 12, color: Color(0xFF94A3B8))),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onDetailRequested,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          backgroundColor: const Color(0xFFEFF6FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('详情',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF2F6FED),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildPagination(),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
            child: _buildTableHeader(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _mockStudents.length,
                itemBuilder: (context, index) {
                  final s = _mockStudents[index];
                  return _buildTableRow(
                    s['name']!,
                    s['gender']!,
                    s['phone']!,
                    s['company']!,
                    s['position']!,
                    s['course']!,
                    s['staff']!,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Column(
              children: [
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 16),
                _buildPagination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: const Row(
        children: [
          Expanded(flex: 2, child: Text('姓名', style: _hStyle)),
          Expanded(flex: 1, child: Text('性别', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text('手机号', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(flex: 3, child: Text('所属企业', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text('职务', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text('最近课程', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text('跟进人员', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text('操作', style: _hStyle, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  static const TextStyle _hStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B));

  Widget _buildTableRow(String name, String gender, String phone, String company, String position, String course, String staff) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)))),
          Expanded(flex: 1, child: Text(gender, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(phone, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)), textAlign: TextAlign.center)),
          Expanded(flex: 3, child: Text(company, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(position, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(course, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)), textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text(staff, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)), textAlign: TextAlign.center)),
          Expanded(
            flex: 1,
            child: Center(
              child: TextButton(
                onPressed: widget.onDetailRequested,
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: const Text('详情', style: TextStyle(fontSize: 13, color: Color(0xFF2F6FED), fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      children: [
        const Text('第 1 到 10 条，共 312 条', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left, size: 20, color: Color(0xFF94A3B8))),
        const Text('1 / 32', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right, size: 20, color: Color(0xFF1E293B))),
      ],
    );
  }
}
