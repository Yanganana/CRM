import 'package:flutter/material.dart';
import 'package:consultant_crm/utils/responsive.dart';

class StudentDetailPage extends StatefulWidget {
  final VoidCallback? onBack;
  const StudentDetailPage({super.key, this.onBack});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  bool _showDrawer = false;
  int _activeTab = 0;
  final ScrollController _scrollController = ScrollController();
  final List<ScrollController> _tableControllers =
      List.generate(7, (index) => ScrollController());

  @override
  void dispose() {
    _scrollController.dispose();
    for (var controller in _tableControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(isMobile ? 12.0 : 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => widget.onBack?.call(),
                    icon: const Icon(Icons.arrow_back,
                        size: 18, color: Color(0xFF64748B)),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  const Text('学员列表',
                      style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                  const Icon(Icons.chevron_right,
                      size: 16, color: Color(0xFF94A3B8)),
                  const Text('学员详情',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSummaryCard(),
                      const SizedBox(height: 20),
                      _buildTabNavigation(),
                      const SizedBox(height: 20),
                      _buildTabContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Scrim Overlay
        if (_showDrawer)
          GestureDetector(
            onTap: () => setState(() => _showDrawer = false),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        // Drawer Trigger Overlay
        _buildDrawerTrigger(),
        // Animated Drawer Panel
        _buildServiceDrawerPanel(),
      ],
    );
  }

  Widget _buildDrawerTrigger() {
    return Positioned(
      right: 0,
      top: MediaQuery.of(context).size.height * 0.15,
      child: InkWell(
        onTap: () => setState(() => _showDrawer = true),
        child: Container(
          width: 32,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2F6FED),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(-2, 0))
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: '查看服务记录'
                .split('')
                .map((char) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(
                        char,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            height: 1.2),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDrawerPanel() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      right: _showDrawer ? 0 : -screenWidth * 0.85,
      top: 0,
      bottom: 0,
      width: screenWidth * 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(-10, 0))
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    const Text('服务记录',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B))),
                    const Spacer(),
                    IconButton(
                        onPressed: () => setState(() => _showDrawer = false),
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: Color(0xFF64748B))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: _buildTimeline(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTab('基础信息', 0),
            _buildTab('性格测试', 1),
            _buildTab('家庭关系', 2),
            _buildTab('参加课程', 3),
            _buildTab('参加活动', 4),
            _buildTab('服务记录', 5),
            _buildTab('影像资料', 6),
            _buildTab('介绍顾客', 7),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final bool isMobile = Responsive.isMobile(context);
    return InkWell(
      onTap: () {
        setState(() {
          _showDrawer = true;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE2E8F0)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://api.dicebear.com/7.x/avataaars/png?seed=John'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('金明',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B))),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(4)),
                            child: const Text('50岁 · 男',
                                style: TextStyle(
                                    fontSize: 11, color: Color(0xFF64748B))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 16),
            Wrap(
              spacing: isMobile ? 12 : 32,
              runSpacing: 12,
              children: [
                _buildInfoItem('出生日期:', '1974-05-12'),
                _buildInfoItem('跟进人员:', '祝菲菲'),
                _buildInfoItem('总消费:', '¥45.0万'),
                _buildInfoItem('上课数:', '4'),
                _buildInfoItem('参加活动:', '20'),
                _buildInfoItem('最近沟通:', '2025-12-16', color: Colors.blue),
                _buildInfoItem('下次沟通:', '2026-01-16', color: Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF999999))),
        const SizedBox(width: 8),
        Text(value,
            style: TextStyle(
                fontSize: 12,
                color: color ?? const Color(0xFF333333),
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isSelected = _activeTab == index;
    return InkWell(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF2F6FED) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color:
                isSelected ? const Color(0xFF2F6FED) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeTab) {
      case 1:
        return _buildPersonalityTest();
      case 2:
        return _buildFamilyRelations();
      case 3:
        return _buildParticipateCourses();
      case 4:
        return _buildParticipateActivities();
      case 5:
        return _buildServiceRecordsTab();
      case 6:
        return _buildImageMaterials();
      case 7:
        return _buildReferredCustomers();
      default:
        return _buildBasicInfoForm();
    }
  }

  Widget _buildBasicInfoForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('核心档案',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A))),
          const SizedBox(height: 24),
          _buildFormGrid([
            _FormFieldData('姓名', '金明'),
            _FormFieldData('性别', '男'),
            _FormFieldData('电话号码', '13800138000'),
            _FormFieldData('区域', '华南'),
            _FormFieldData('城市', '深圳'),
            _FormFieldData('消费额', '¥450,000'),
          ]),
          const SizedBox(height: 16),
          _buildFullWidthField('参加课程', '数字化转型、领导力研讨'),
          const SizedBox(height: 16),
          _buildFullWidthField('参加活动', '217期实践令、年度峰会'),
          const SizedBox(height: 24),
          Container(height: 1, color: const Color(0xFFE2E8F0)),
          const SizedBox(height: 24),
          const Text('扩展信息',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A))),
          const SizedBox(height: 20),
          _buildFormGrid([
            _FormFieldData('微信', 'jm_wechat_001'),
            _FormFieldData('邮箱', 'jinming@example.com'),
            _FormFieldData('跟进人', '祝菲菲'),
          ]),
          const SizedBox(height: 16),
          _buildFullWidthField('兴趣爱好', '公众号、视频号、电影、书籍'),
          const SizedBox(height: 16),
          _buildFullWidthField('备注说明', '该学员对数字化转型非常感兴趣，具有较强的学习意愿，建议重点跟进。'),
        ],
      ),
    );
  }

  Widget _buildFormGrid(List<_FormFieldData> fields) {
    final bool isMobile = Responsive.isMobile(context);
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: fields
          .map((f) => SizedBox(
                width: isMobile
                    ? (MediaQuery.of(context).size.width - 80) / 2
                    : 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f.label,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF94A3B8))),
                    const SizedBox(height: 4),
                    Text(f.value,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildFullWidthField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 13, color: Color(0xFF1E293B), height: 1.5)),
      ],
    );
  }

  Widget _buildPersonalityTest() {
    return Column(
      children: [
        _buildDetailedPersonalityCard(
            '2025-12-10', '力量型', '90', '46-55岁', '56', '9', '15', '5', '11'),
        _buildDetailedPersonalityCard(
            '2024-10-10', '力量型', '90', '46-55岁', '56', '10', '15', '5', '11'),
        _buildDetailedPersonalityCard(
            '2023-05-08', '力量型', '89', '46-55岁', '56', '9', '15', '5', '11'),
      ],
    );
  }

  Widget _buildDetailedPersonalityCard(
      String date,
      String type,
      String desire,
      String psychAge,
      String ageScore,
      String active,
      String power,
      String perfect,
      String peaceful) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFF2F6FED).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(type,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F6FED))),
              ),
              Text('成功欲望: $desire',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 16),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 40,
              crossAxisSpacing: 12,
            ),
            children: [
              _buildSmallMetric('心理年龄', psychAge),
              _buildSmallMetric('年龄得分', ageScore),
              _buildSmallMetric('活泼', active),
              _buildSmallMetric('力量', power),
              _buildSmallMetric('完美', perfect),
              _buildSmallMetric('平和', peaceful),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('查看试卷详情',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2F6FED),
                      decoration: TextDecoration.underline)),
              SizedBox(width: 4),
              Icon(Icons.arrow_outward_rounded,
                  size: 14, color: Color(0xFF2F6FED)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallMetric(String label, String value) {
    return Row(
      children: [
        Text('$label: ',
            style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
        Text(value,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B))),
      ],
    );
  }

  Widget _buildAddBtn(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add, size: 16, color: Color(0xFF2F6FED)),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F6FED))),
        ],
      ),
    );
  }

  Widget _buildFamilyRelations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAddBtn('新增成员'),
        const SizedBox(height: 16),
        _buildFamilyCard('金董', '父亲', '赢家集团', '138****8888'),
        _buildFamilyCard('金太太', '妻子', '家庭主妇', '139****9999'),
        _buildFamilyCard('金小明', '儿子', '赢家私立学校', '-'),
      ],
    );
  }

  Widget _buildFamilyCard(
      String name, String relation, String work, String phone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(relation,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF64748B))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.business_rounded,
                  size: 14, color: Color(0xFF94A3B8)),
              const SizedBox(width: 8),
              Text(work,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              const Spacer(),
              const Icon(Icons.phone_iphone_rounded,
                  size: 14, color: Color(0xFF94A3B8)),
              const SizedBox(width: 8),
              Text(phone,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParticipateCourses() {
    final headers = [
      '课程类别',
      '课程名称',
      '开始时间',
      '参加人数',
      '费用总计',
      '讲师',
      '考勤',
      '课题报告'
    ];
    final rows = [
      ['理念经营', '理念经营-56', '2018-10-22', '1', '1,200', '周南征', '100%', '查看详情'],
      ['理念经营', '理念经营-56', '2018-10-22', '1', '1,200', '周南征', '100%', '查看详情'],
      ['理念经营', '理念经营-56', '2018-10-22', '1', '1,200', '周南征', '100%', '查看详情'],
      ['理念经营', '理念经营-56', '2018-10-22', '1', '1,200', '周南征', '100%', '查看详情'],
      ['理念经营', '理念经营-56', '2018-10-22', '1', '1,200', '周南征', '95%', '查看详情'],
    ];
    return _buildFullTable(headers: headers, rows: rows, linkColumns: {7});
  }

  Widget _buildReferredCustomers() {
    final headers = ['序号', '企业名', '联系人', '录入时间', '录入者', '担当人', '参加课程', '等级'];
    final rows = [
      ['1', '深南大道科技有限公司', '张晓明', '2025-10-22', '祝菲菲', '李敏', '理念经营-56', 'V类'],
      ['2', '深南大道科技有限公司', '张晓明', '2025-10-22', '祝菲菲', '李敏', '理念经营-56', 'V类'],
      ['3', '深南大道科技有限公司', '张晓明', '2025-10-22', '祝菲菲', '李敏', '理念经营-56', 'V类'],
      ['4', '深南大道科技有限公司', '张晓明', '2025-10-22', '祝菲菲', '李敏', '理念经营-56', 'V类'],
      ['5', '深南大道科技有限公司', '张晓明', '2025-10-22', '祝菲菲', '李敏', '理念经营-56', 'V类'],
    ];
    return _buildFullTable(headers: headers, rows: rows);
  }

  Widget _buildFullTable({
    required List<String> headers,
    required List<List<String>> rows,
    Set<int> linkColumns = const {},
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 40,
          ),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: const TableBorder(
              horizontalInside: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
            children: [
              // Header row
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
                children: headers
                    .map((h) => TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: Text(
                              h,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              // Data rows
              ...rows.asMap().entries.map((entry) {
                final rowIndex = entry.key;
                final row = entry.value;
                return TableRow(
                  decoration: BoxDecoration(
                    color:
                        rowIndex.isOdd ? const Color(0xFFFAFBFC) : Colors.white,
                  ),
                  children: row.asMap().entries.map((cell) {
                    final colIndex = cell.key;
                    final text = cell.value;
                    final isLink = linkColumns.contains(colIndex);
                    return TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 13,
                            color: isLink
                                ? const Color(0xFF2F6FED)
                                : const Color(0xFF1E293B),
                            decoration: isLink
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            fontWeight:
                                isLink ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticipateActivities() {
    return Column(
      children: [
        _buildBusinessCard(
          title: '实践令-第217期',
          subtitle: '2025-12-16',
          badge: '业务活动',
          metrics: {'讲师': '周南征', '参加人数': '75', '分享嘉宾': '金明、义洁萍'},
          fullWidthMetric: {'活动主题': '细分化选道、数智化强基、国际化扩展'},
          links: ['企划书', '会议纪要', '实施调查表'],
        ),
      ],
    );
  }

  Widget _buildServiceRecordsTab() {
    return Column(
      children: [
        _buildBusinessCard(
          title: '面谈沟通',
          subtitle: '2025-12-16',
          badge: '服务记录',
          metrics: {'沟通对象': '金明、义洁萍', '责任人': '张三', '协助者': '-'},
          fullWidthMetric: {'沟通简讯': '该学员近期参与了数字化转型研讨，展现出极高的活跃度。建议重点跟进。'},
          links: ['沟通结果', '照片'],
        ),
      ],
    );
  }

  Widget _buildBusinessCard({
    required String title,
    required String subtitle,
    required String badge,
    required Map<String, String> metrics,
    Map<String, String>? fullWidthMetric,
    required List<String> links,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(badge,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF2F6FED),
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
          const SizedBox(height: 16),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: metrics.entries
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.key,
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFF94A3B8))),
                        const SizedBox(height: 2),
                        Text(e.value,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF475569))),
                      ],
                    ))
                .toList(),
          ),
          if (fullWidthMetric != null) ...[
            const SizedBox(height: 16),
            ...fullWidthMetric.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.key,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF94A3B8))),
                      const SizedBox(height: 4),
                      Text(e.value,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF475569),
                              height: 1.5)),
                    ],
                  ),
                )),
          ],
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: links
                .map((l) => Text(l,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF2F6FED),
                        decoration: TextDecoration.underline)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageMaterials() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection('企业照片', imageCount: 4, maxCount: 5),
          const SizedBox(height: 24),
          _buildImageSection('企业LOGO与品牌LOGO', imageCount: 2, maxCount: 3),
          const SizedBox(height: 24),
          _buildImageSection('店铺照片', imageCount: 7, maxCount: 8),
          const SizedBox(height: 24),
          _buildImageSection('生产现场', imageCount: 4, maxCount: 5),
        ],
      ),
    );
  }

  Widget _buildImageSection(String title,
      {required int imageCount, required int maxCount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            // Image thumbnails
            ...List.generate(imageCount, (index) {
              return _buildImageThumbnail(seed: index + 1);
            }),
            // Add button (if not at max)
            if (imageCount < maxCount) _buildAddImageButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildImageThumbnail({required int seed}) {
    return Container(
      width: 110,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFBFD7FE), width: 1),
      ),
      child: Stack(
        children: [
          // Mountain/landscape image placeholder
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CustomPaint(
                painter: _LandscapePlaceholderPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddImageButton() {
    return Container(
      width: 110,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
      ),
      child: const Center(
        child: Icon(Icons.add, size: 28, color: Color(0xFF94A3B8)),
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
        children: List.generate(3, (i) => _buildTimelineItem(i == 2)));
  }

  Widget _buildTimelineItem(bool last) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [
            Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                    color: Color(0xFF2F6FED), shape: BoxShape.circle)),
            if (!last)
              Expanded(
                  child: Container(width: 2, color: const Color(0xFFE2E8F0)))
          ]),
          const SizedBox(width: 16),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2025-12-16 面谈沟通',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF1E293B))),
                  SizedBox(height: 8),
                  Text('该学员近期参与了数字化转型研讨，展现出极高的活跃度。建议后期重点跟进。',
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFF475569), height: 1.5)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: [
                      Text('沟通结果',
                          style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF2F6FED),
                              decoration: TextDecoration.underline)),
                      Text('照片',
                          style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF2F6FED),
                              decoration: TextDecoration.underline)),
                    ],
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

class _FormFieldData {
  final String label;
  final String value;
  _FormFieldData(this.label, this.value);
}

/// Custom painter to render a landscape/mountain image placeholder (similar to prototype wireframe icons)
class _LandscapePlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF5BA4F5);
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Sun circle
    final sunPaint = Paint()..color = const Color(0xFF90C4FF);
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.28),
        size.width * 0.09, sunPaint);

    // Mountain (back)
    final mountainBackPaint = Paint()..color = const Color(0xFF3A82E0);
    final pathBack = Path()
      ..moveTo(size.width * 0.30, size.height)
      ..lineTo(size.width * 0.62, size.height * 0.30)
      ..lineTo(size.width * 1.05, size.height)
      ..close();
    canvas.drawPath(pathBack, mountainBackPaint);

    // Mountain (front)
    final mountainFrontPaint = Paint()..color = const Color(0xFF2F6FED);
    final pathFront = Path()
      ..moveTo(-size.width * 0.05, size.height)
      ..lineTo(size.width * 0.38, size.height * 0.42)
      ..lineTo(size.width * 0.73, size.height)
      ..close();
    canvas.drawPath(pathFront, mountainFrontPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
