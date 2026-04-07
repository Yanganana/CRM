import 'package:flutter/material.dart';
import 'package:consultant_crm/utils/responsive.dart';
import 'package:image_picker/image_picker.dart';

class _MetricRowData {
  final String title;
  final List<double> values;
  final bool isRateHidden;
  _MetricRowData(this.title, this.values, {this.isRateHidden = false});
}

class EnterpriseDetailPage extends StatefulWidget {
  final VoidCallback? onBack;
  const EnterpriseDetailPage({super.key, this.onBack});

  @override
  State<EnterpriseDetailPage> createState() => _EnterpriseDetailPageState();
}

class _EnterpriseDetailPageState extends State<EnterpriseDetailPage> {
  int _activeTab = 0;
  String _selectedFinancialYear = '2025年';
  bool _isEditing = false;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    final List<Map<String, String>> mockValues = [
      {'企业简称:': '赢家时尚'},
      {'企业注册名:': '赢家时尚控股有限公司'},
      {'存续状态:': '已开业 / 正常状况'},
      {'统一社会信用代码:': '914403007954128XXX'},
      {'区域:': '华南'},
      {'城市:': '深圳'},
      {'行业:': '服装品牌 / 零售'},
      {'注册资本:': '12,000,000 HKD'},
      {'人员规模:': '1000人以上'},
      {'法人代表:': '金明'},
      {'联系人:': '李静'},
      {'联系电话:': '0755-8888XXXX'},
      {'网站地址:': 'www.ee-winner.com'},
      {'公司地址:': '深圳市福田区深南大道赢家时尚大厦'},
      {'事业描述:': '中国高端女装领域的领军企业，旗下拥有多个知名品牌，致力于为精英女性提供全场景的着装解决方案。'},
      {'事业数量:': '8个核心品牌'},
      {'品牌名称:': 'NAERSI, KORADIOR, NEXY.CO, etc.'},
      {'关联公司:': '香港赢家服饰集团'},
      {'交易价值:': '高价值客户'},
      {'服务等级:': 'V级核心服务'},
      {'转介绍类别:': '老客户转介绍'},
      {'转介绍企业:': '歌力思服饰'},
      {'转介绍人:': '周总'},
      {'转介绍企业顾客等级:': 'V类'},
      {'转介绍人能力:': '极强社交影响力'},
      {'转介绍课程:': '理念经营-56期'},
    ];

    for (var m in mockValues) {
      _controllers[m.keys.first] = TextEditingController(text: m.values.first);
    }
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('成功选择并上传: ${image.name}'),
            duration: const Duration(seconds: 2),
            backgroundColor: const Color(0xFF2F6FED),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('选择图片失败，请检查相关权限覆盖')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumb(),
            const SizedBox(height: 16),
            _buildSummaryHeader(),
            const SizedBox(height: 24),
            _buildTabsAndContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Row(
      children: [
        IconButton(
          onPressed: () => widget.onBack?.call(),
          icon:
              const Icon(Icons.arrow_back, size: 18, color: Color(0xFF64748B)),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        const Text('企业列表',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
        const Icon(Icons.chevron_right, size: 16, color: Color(0xFF94A3B8)),
        const Text('企业详情',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B))),
      ],
    );
  }

  Widget _buildSummaryHeader() {
    final bool isMobile = Responsive.isMobile(context);

    final headerContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '赢家时尚控股有限公司',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 20),
        _buildHeaderInfoGrid(),
      ],
    );

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
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
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildCompanyLogo()),
                const SizedBox(height: 24),
                headerContent,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCompanyLogo(),
                const SizedBox(width: 32),
                Expanded(child: headerContent),
              ],
            ),
    );
  }

  Widget _buildCompanyLogo() {
    final bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? 100 : 120,
      height: isMobile ? 100 : 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      padding: const EdgeInsets.all(8),
      child: Image.network(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz-4P-X3f_HjgW_vO8P4g-u4O_iE0l9F_30A&s',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildHeaderInfoGrid() {
    final bool isMobile = Responsive.isMobile(context);
    if (!isMobile) {
      return Wrap(
        spacing: 40,
        runSpacing: 16,
        children: [
          _buildSummaryItem('顾客等级:', 'V类', valueColor: const Color(0xFFF43F5E)),
          _buildSummaryItem('行业:', '服装品牌'),
          _buildSummaryItem('区域:', '华南'),
          _buildSummaryItem('城市:', '深圳'),
          _buildSummaryItem('销售额:', '80亿'),
          _buildSummaryItem('规模:', '1000人+'),
          _buildSummaryItem('担当部门:', '市场开发部'),
          _buildSummaryItem('担当人员:', '祝菲菲'),
          _buildSummaryItem('最近服务时间:', '2025-12-16'),
          _buildSummaryItem('下次服务时间:', '2026-01-16'),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _buildSummaryItem('等级:', 'V类',
                    valueColor: const Color(0xFFF43F5E))),
            Expanded(child: _buildSummaryItem('行业:', '服装品牌')),
            Expanded(child: _buildSummaryItem('区域:', '华南')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSummaryItem('城市:', '深圳')),
            Expanded(child: _buildSummaryItem('销售额:', '80亿')),
            Expanded(child: _buildSummaryItem('规模:', '1000人+')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSummaryItem('担当部门:', '市场开发部')),
            Expanded(child: _buildSummaryItem('担当人员:', '祝菲菲')),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildSummaryItem('最近服务时间:', '2025-12-16')),
            Expanded(child: _buildSummaryItem('下次服务时间:', '2026-01-16')),
            const Spacer(),
          ],
        ),
      ],
    );
  }


  Widget _buildSummaryItem(String label, String value,
      {Color? valueColor, bool isFullWidth = false}) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: valueColor ?? const Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsAndContent() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  '基础信息',
                  '经营信息',
                  '组织信息',
                  '参加课程',
                  '参加活动',
                  '服务记录',
                  '影像资料',
                  '介绍顾客'
                ].asMap().entries.map((entry) {
                  final isSelected = _activeTab == entry.key;
                  return GestureDetector(
                    onTap: () => setState(() => _activeTab = entry.key),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: isSelected
                                    ? const Color(0xFF2F6FED)
                                    : Colors.transparent,
                                width: 2.5)),
                      ),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF2F6FED)
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          Padding(
            padding: const EdgeInsets.all(16), // Reduced from 24
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeTab) {
      case 0:
        return _buildBasicInfoSection();
      case 1:
        return _buildBusinessInfoSection();
      case 2:
        return _buildOrgInfoSection();
      case 3:
        return _buildCourseInfoSection();
      case 4:
        return _buildActivityInfoSection();
      case 5:
        return _buildServiceInfoSection();
      case 6:
        return _buildMediaSection();
      case 7:
        return _buildIntroducedCustomersSection();
      default:
        return _buildBasicInfoSection();
    }
  }

  Widget _buildMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageCategory('企业照片', 4),
        const SizedBox(height: 24),
        _buildImageCategory('企业LOGO与品牌LOGO', 2),
        const SizedBox(height: 24),
        _buildImageCategory('店铺照片', 7),
        const SizedBox(height: 24),
        _buildImageCategory('生产现场', 4),
      ],
    );
  }

  Widget _buildImageCategory(String title, int count) {
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
            ...List.generate(count, (index) => _buildImgThumb()),
            _buildAddImgBtn(),
          ],
        ),
      ],
    );
  }

  Widget _buildImgThumb() {
    return Container(
      width: 110,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFBFD7FE), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CustomPaint(painter: _LandscapePainter()),
      ),
    );
  }

  Widget _buildAddImgBtn() {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 110,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
        ),
        child: const Center(
          child: Icon(Icons.add, size: 28, color: Color(0xFF94A3B8)),
        ),
      ),
    );
  }

  Widget _buildIntroducedCustomersSection() {
    final bool isMobile = Responsive.isMobile(context);
    final data = List.generate(
        5,
        (index) => {
              'id': '${index + 1}',
              'company': '深南大道科技有限公司',
              'contact': '张晓明',
              'time': '2025-10-22',
              'owner': '祝菲菲',
              'staff': '李敏',
              'course': '理念经营-56',
              'grade': 'V类',
              'level': 'S级'
            });

    if (isMobile) {
      return Column(
        children: data
            .map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(c['company']!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B)))),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(c['grade']!,
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF10B981),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const Divider(height: 24, color: Color(0xFFF8FAFC)),
                      Row(
                        children: [
                          Expanded(child: _mobileInfoRow('联系人', c['contact']!)),
                          Expanded(child: _mobileInfoRow('级别', c['level']!)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: _mobileInfoRow('录入人', c['owner']!)),
                          Expanded(child: _mobileInfoRow('担当', c['staff']!)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _mobileInfoRow('参加课程', c['course']!),
                      _mobileInfoRow('录入时间', c['time']!),
                    ],
                  ),
                ))
            .toList(),
      );
    }

    final headers = ['序号', '企业名', '联系人', '录入时间', '录入者', '担当人', '参加课程', '等级'];
    final rows = data
        .map((item) => [
              item['id']!,
              item['company']!,
              item['contact']!,
              item['time']!,
              item['owner']!,
              item['staff']!,
              item['course']!,
              item['grade']!
            ])
        .toList();
    return _buildEntFullTable(headers: headers, rows: rows, boldColumns: {1});
  }

  Widget _buildServiceInfoSection() {
    final bool isMobile = Responsive.isMobile(context);
    final services = List.generate(
        3,
        (index) => {
              'date': index == 0 ? '2025-12-16' : '2025-11-08',
              'type': index == 0 ? '面谈沟通' : '微信沟通',
              'target': '金明、义洁萍',
              'owner': '祝菲菲',
              'summary': '关于数字化转型的初步沟通...',
            });

    if (isMobile) {
      return Column(
        children: services
            .map((s) => Container(
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(s['type']!,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569))),
                          ),
                          Text(s['date']!,
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xFF64748B))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _mobileInfoRow('沟通对象', s['target']!),
                      _mobileInfoRow('责任者', s['owner']!),
                      const SizedBox(height: 8),
                      const Text('沟通简讯:',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF64748B))),
                      const SizedBox(height: 4),
                      Text(s['summary']!,
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF1E293B))),
                      const Divider(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                      color: Color(0xFFE2E8F0)),
                                ),
                                child: const FittedBox(
                                    child: Text('会议纪要',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF64748B))))),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                      color: Color(0xFFE2E8F0)),
                                ),
                                child: const FittedBox(
                                    child: Text('提案PPT',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF64748B))))),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2F6FED),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    elevation: 0),
                                child: const FittedBox(
                                    child: Text('详情',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
            .toList(),
      );
    }

    return Column(
      children: [
        _buildServiceTableContainer(),
      ],
    );
  }


  Widget _buildServiceTableContainer() {
    final ScrollController serviceScrollController = ScrollController();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.circular(12)),
          child: Scrollbar(
            controller: serviceScrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: serviceScrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  _buildServiceTableHeader(),
                  ...List.generate(10, (index) => _buildServiceRow(index)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildPaginationFooter(10, 10),
      ],
    );
  }

  Widget _buildServiceTableHeader() {
    final headers = [
      '服务时间',
      '服务方式',
      '沟通对象',
      '责任者',
      '协助者',
      '沟通简讯',
      '企业课题',
      '沟通结果',
      '查看详情',
      '提案PPT',
      '会议纪要'
    ];
    return Container(
      height: 48,
      width: 1400,
      decoration: const BoxDecoration(
          color: Color(0xFFEDF2F7),
          border: Border(bottom: BorderSide(color: Color(0xFFCBD5E1)))),
      child: Row(
        children: headers
            .asMap()
            .entries
            .map((e) => Container(
                  width: e.key == 5 ? 240 : (e.key == 0 ? 100 : 106),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          right: e.key == headers.length - 1
                              ? BorderSide.none
                              : const BorderSide(color: Color(0xFFCBD5E1)))),
                  child: Text(e.value,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildServiceRow(int index) {
    final isEven = index % 2 != 0;
    final rowData = [
      index == 0 ? '2025-12-16' : (index == 1 ? '2025-11-08' : '-'),
      index == 0 ? '面谈沟通' : (index == 1 ? '微信沟通' : '-'),
      index == 0 ? '金明、义洁萍' : '-',
      '-',
      '-',
      '-',
      index == 0 ? '查看详情' : '-',
      index == 0 ? '查看详情' : '-',
      index == 0 ? '查看详情' : '-',
      '-',
      index == 0 ? '查看详情' : '-',
    ];

    return Container(
      height: 44,
      width: 1400,
      decoration: BoxDecoration(
          color: isEven ? const Color(0xFFF8FAFC) : Colors.white,
          border: const Border(bottom: BorderSide(color: Color(0xFFCBD5E1)))),
      child: Row(
        children: rowData.asMap().entries.map((e) {
          final isLink = e.value == '查看详情';
          return Container(
            width: e.key == 5 ? 240 : (e.key == 0 ? 100 : 106),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    right: e.key == rowData.length - 1
                        ? BorderSide.none
                        : const BorderSide(color: Color(0xFFCBD5E1)))),
            child: isLink
                ? TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, minimumSize: Size.zero),
                    child: Text(e.value,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF2F6FED))))
                : Text(e.value,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF475569))),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActivityInfoSection() {
    final bool isMobile = Responsive.isMobile(context);
    final activities = List.generate(
        4,
        (index) => {
              'date': '2018-10-22',
              'category': '实践令',
              'name': '实践令-第262期',
              'theme': '经营理念的落地',
              'host': '周南征',
              'coHost': '深南分部',
              'presenter': '张晓明',
              'followup': '赵主管',
            });

    if (isMobile) {
      return Column(
        children: activities
            .map((a) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(a['name']!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B)))),
                          Text(a['date']!,
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xFF64748B))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 12),
                      _mobileInfoRow('活动类别', a['category']!),
                      _mobileInfoRow('活动主题', a['theme']!),
                      _mobileInfoRow('协办单位', a['coHost']!),
                      _mobileInfoRow('主持人', a['host']!),
                      _mobileInfoRow('发表者', a['presenter']!),
                      _mobileInfoRow('跟进责任者', a['followup']!),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildMobileActionBtn('调查问答', () {}),
                          _buildMobileActionBtn('参加成员', () {}, isPrimary: true),
                        ],
                      ),
                    ],
                  ),
                ))
            .toList(),
      );
    }

    return Column(
      children: [
        _buildActivityTableContainer(),
      ],
    );
  }



  Widget _buildActivityTableContainer() {
    final ScrollController activityScrollController = ScrollController();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.circular(12)),
          child: Scrollbar(
            controller: activityScrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: activityScrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  _buildActivityTableHeader(),
                  ...List.generate(8, (index) => _buildActivityRow(index)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildPaginationFooter(8, 10),
      ],
    );
  }

  Widget _buildActivityTableHeader() {
    final headers = [
      '活动时间',
      '活动类别',
      '活动名称',
      '活动主题',
      '协办单位',
      '主持人',
      '发表者',
      '实施调查问答',
      '跟进责任者',
      '参加成员'
    ];
    return Container(
      height: 48,
      width: 1200,
      decoration: const BoxDecoration(
          color: Color(0xFFEDF2F7),
          border: Border(bottom: BorderSide(color: Color(0xFFCBD5E1)))),
      child: Row(
        children: headers
            .asMap()
            .entries
            .map((e) => Container(
                  width: e.key == 3 ? 200 : 111,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          right: e.key == headers.length - 1
                              ? BorderSide.none
                              : const BorderSide(color: Color(0xFFCBD5E1)))),
                  child: Text(e.value,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildActivityRow(int index) {
    final isEven = index % 2 != 0;
    String category = '实践令';
    String name = '实践令-第262期';
    if (index == 1) {
      category = '精进课堂';
    } else if (index == 2)
      category = '班委活动';
    else if (index == 3) category = '毕业典礼';

    final rowData = [
      index == 0 ? '2018-10-22' : '-',
      category,
      index == 0 ? name : '-',
      index == 0 ? '1' : '-',
      '-',
      '-',
      index == 0 ? '周南征' : '-',
      '查看详情',
      index == 0 ? '陆祁仁' : '-',
      '查看详情'
    ];

    return Container(
      height: 44,
      width: 1200,
      decoration: BoxDecoration(
          color: isEven ? const Color(0xFFF8FAFC) : Colors.white,
          border: const Border(bottom: BorderSide(color: Color(0xFFCBD5E1)))),
      child: Row(
        children: rowData.asMap().entries.map((e) {
          final isLink = e.value == '查看详情';
          return Container(
            width: e.key == 3 ? 200 : 111,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    right: e.key == rowData.length - 1
                        ? BorderSide.none
                        : const BorderSide(color: Color(0xFFCBD5E1)))),
            child: isLink
                ? TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, minimumSize: Size.zero),
                    child: Text(e.value,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF2F6FED))))
                : Text(e.value,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF475569))),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCourseInfoSection() {
    final bool isMobile = Responsive.isMobile(context);
    final courses = List.generate(
        6,
        (index) => {
              'category': index >= 4 ? '指导会' : '理念经营',
              'name': index == 0 ? '理念经营-56' : (index == 1 ? '理念经营-50' : '-'),
              'date': index == 0 ? '2018-10-22' : '2020-05-12',
              'students': '1',
              'cost': '1,200',
              'teacher': '周南征',
              'attendance': '100%',
            });

    if (isMobile) {
      return Column(
        children: courses
            .map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(c['name']!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B)))),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(c['category']!,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF2F6FED),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 12),
                      _mobileInfoRow('开始时间', c['date']!),
                      _mobileInfoRow('企业参加人数', c['students']!),
                      _mobileInfoRow('费用总计', '¥${c['cost']}'),
                      _mobileInfoRow('讲师', c['teacher']!),
                      _mobileInfoRow('事务局组长', '李振鹏'),
                      _mobileInfoRow('运营人员', '陆祁仁'),
                      _mobileInfoRow('考勤情况', c['attendance']!),
                      _mobileInfoRow('毕业人数', '1人'),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildMobileActionBtn('调查问卷', () {}),
                          _buildMobileActionBtn('课题报告', () {}),
                          _buildMobileActionBtn('毕业面谈', () {}),
                          _buildMobileActionBtn('毕业发表', () {}),
                        ],
                      ),
                    ],
                  ),
                ))
            .toList(),
      );
    }

    final headers = [
      '课程类别',
      '课程名称',
      '开始时间',
      '企业参加人数',
      '费用总计',
      '讲师',
      '事务局组长',
      '运营人员',
      '考勤',
      '实施调查表',
      '课题报告',
      '毕业人数',
      '毕业面谈纪要',
      '毕业发表纪要'
    ];
    final rows = List.generate(
        10,
        (index) => [
              index >= 4 ? '指导会' : '理念经营',
              index == 0 ? '理念经营-56' : (index == 1 ? '理念经营-50' : '-'),
              index == 0 ? '2018-10-22' : '2020-05-12',
              '1',
              '12.5万',
              '周南征',
              '李振鹏',
              '陆祁仁',
              '100%',
              '查看详情',
              '查看详情',
              '1',
              '查看详情',
              '查看详情'
            ]);
    return _buildEntFullTable(
        headers: headers, rows: rows, linkColumns: {9, 10, 12, 13});
  }

  Widget _mobileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          Text(value,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569))),
        ],
      ),
    );
  }

  Widget _buildMobileActionBtn(String label, VoidCallback? onTap,
      {bool isPrimary = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: isPrimary
                  ? const Color(0xFFBFD7FE)
                  : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color:
                isPrimary ? const Color(0xFF2F6FED) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildEntFullTable({
    required List<String> headers,
    required List<List<String>> rows,
    Set<int> linkColumns = const {},
    Set<int> boldColumns = const {},
  }) {
    final bool isMobile = Responsive.isMobile(context);
    final ScrollController horizontalController = ScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double minW = isMobile ? 1200 : 1800;
        return Column(
          children: [
            Container(
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
              child: Scrollbar(
                controller: horizontalController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: minW),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: headers.isNotEmpty && headers.first == '序号' 
                          ? const FixedColumnWidth(60) 
                          : const IntrinsicColumnWidth(), // Let category expand if it's not a serial number
                      },
                      defaultColumnWidth: const FlexColumnWidth(),
                      border: const TableBorder(
                        horizontalInside: BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      children: [
                        TableRow(
                          decoration:
                              const BoxDecoration(color: Color(0xFFF8FAFC)),
                          children: headers
                              .map((h) => TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 14),
                                      child: Text(h,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF64748B),
                                          )),
                                    ),
                                  ))
                              .toList(),
                        ),
                        ...rows.asMap().entries.map((entry) {
                          final i = entry.key;
                          final row = entry.value;
                          return TableRow(
                            decoration: BoxDecoration(
                              color: i.isOdd
                                  ? const Color(0xFFFAFBFC)
                                  : Colors.white,
                            ),
                            children: row.asMap().entries.map((cell) {
                              final col = cell.key;
                              final text = cell.value;
                              final isLink = linkColumns.contains(col);
                              final isBold = boldColumns.contains(col);
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
                                      fontWeight: (isLink || isBold)
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
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
              ),
            ),
            const SizedBox(height: 16),
            _buildPaginationFooter(rows.length, 10),
          ],
        );
      },
    );
  }

  Widget _buildPaginationFooter(int total, int perPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '共 $total 条记录，每页显示 $perPage 条',
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
        Row(
          children: [
            _buildPageBtn(Icons.chevron_left, false),
            const SizedBox(width: 8),
            _buildPageNum(1, true),
            const SizedBox(width: 8),
            _buildPageNum(2, false),
            const SizedBox(width: 8),
            _buildPageBtn(Icons.chevron_right, true),
          ],
        ),
      ],
    );
  }

  Widget _buildPageBtn(IconData icon, bool enabled) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: enabled ? const Color(0xFFE2E8F0) : const Color(0xFFF1F5F9)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon,
          size: 18, color: enabled ? const Color(0xFF64748B) : const Color(0xFFCBD5E1)),
    );
  }

  Widget _buildPageNum(int num, bool active) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2F6FED) : Colors.white,
        border: Border.all(
            color: active ? const Color(0xFF2F6FED) : const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$num',
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: active ? Colors.white : const Color(0xFF64748B)),
      ),
    );
  }

  Widget _buildOrgInfoSection() {
    final bool isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          _buildMemberCard(),
          const SizedBox(height: 24),
          _buildOrgTopologyCard(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: _buildMemberCard()),
        const SizedBox(width: 32),
        Expanded(flex: 5, child: _buildOrgTopologyCard()),
      ],
    );
  }

  Widget _buildMemberCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('关键成员列表',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B))),
                TextButton(
                  onPressed: () {},
                  child: const Text('+ 新增成员',
                      style: TextStyle(fontSize: 12, color: Color(0xFF2F6FED))),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _buildOrgTable(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildOrgTable() {
    final bool isMobile = Responsive.isMobile(context);
    final members = [
      {
        'index': '1',
        'name': '陈建华',
        'position': '董事长',
        'duty': '全面负责',
        'status': '在职'
      },
      {
        'index': '2',
        'name': '李明德',
        'position': '总经理',
        'duty': '日常经营',
        'status': '在职'
      },
      {
        'index': '3',
        'name': '王晓芳',
        'position': '财务总监',
        'duty': '资金管控',
        'status': '在职'
      },
      {
        'index': '4',
        'name': '赵庆余',
        'position': '人事主管',
        'duty': '人才招聘',
        'status': '在职'
      },
      {
        'index': '5',
        'name': '孙大伟',
        'position': '技术主管',
        'duty': '后勤保障',
        'status': '在职'
      },
      {
        'index': '6',
        'name': '周南征',
        'position': '特级工程师',
        'duty': '技术研发',
        'status': '在职'
      },
    ];

    if (isMobile) {
      return Column(
        children: members.map((m) => _buildMemberMobileCard(m)).toList(),
      );
    }

    final headers = ['序号', '员工姓名', '职位', '职务', '在职状态', '操作'];
    return Column(
      children: [
        Container(
          height: 48,
          decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
          child: Row(
            children: headers
                .map((h) => Expanded(
                    child: Center(
                        child: Text(h,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF64748B))))))
                .toList(),
          ),
        ),
        ...members.asMap().entries.map((entry) {
          final isEven = entry.key % 2 != 0;
          final m = entry.value;
          return Container(
            height: 52,
            decoration: BoxDecoration(
              color: isEven ? const Color(0xFFFBFDFF) : Colors.white,
              border:
                  const Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: Text(m['index']!,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF94A3B8))))),
                Expanded(
                    child: Center(
                        child: Text(m['name']!,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B))))),
                Expanded(
                    child: Center(
                        child: Text(m['position']!,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF475569))))),
                Expanded(
                    child: Center(
                        child: Text(m['duty']!,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF475569))))),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text('在职',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF166534),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('详情',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF2F6FED)))))),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildPaginationFooter(members.length, 10),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMemberMobileCard(Map<String, String> m) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(m['name']!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B))),
                    const SizedBox(width: 8),
                    const Text('在职',
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF10B981),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 2),
                Text('${m['position']} | ${m['duty']}',
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 12, color: Color(0xFFCBD5E1)),
        ],
      ),
    );
  }

  Widget _buildOrgTopologyCard() {
    final bool isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('组织架构拓扑',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                _buildOrgNode('董事长', isPrimary: true),
                _buildOrgLine(isMobile ? 12 : 24),
                _buildOrgNode('总经理', isPrimary: true),
                _buildOrgLine(isMobile ? 12 : 24),
                _buildOrgBranchedLine(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOrgNode('财务部', isSmall: true),
                      const SizedBox(width: 8),
                      _buildOrgNode('人事部', isSmall: true),
                      const SizedBox(width: 8),
                      _buildOrgNode('市场部', isSmall: true),
                      const SizedBox(width: 8),
                      _buildOrgNode('研发部', isSmall: true),
                      const SizedBox(width: 8),
                      _buildOrgNode('销售部', isSmall: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendIcon(const Color(0xFF2F6FED), '高层管理'),
              const SizedBox(width: 16),
              _legendIcon(const Color(0xFFE2E8F0), '职能部门', isBorder: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendIcon(Color color, String label, {bool isBorder = false}) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border:
                isBorder ? Border.all(color: const Color(0xFFCBD5E1)) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildOrgNode(String title,
      {bool isPrimary = false, bool isSmall = false}) {
    return Container(
      width: isSmall ? 80 : 120,
      height: isSmall ? 40 : 48,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF3B82F6) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: isPrimary ? null : Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2))
              ]
            : null,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: isSmall ? 11 : 13,
            fontWeight: FontWeight.bold,
            color: isPrimary ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildOrgLine(double height) {
    return Container(
        width: 1.5, height: height, color: const Color(0xFFE2E8F0));
  }

  Widget _buildOrgBranchedLine() {
    return Column(
      children: [
        Container(width: 2, height: 12, color: const Color(0xFFE2E8F0)),
        Container(
          width: 280,
          height: 2,
          color: const Color(0xFFE2E8F0),
        ),
        Container(width: 2, height: 12, color: const Color(0xFFE2E8F0)),
      ],
    );
  }

  Widget _buildBusinessInfoSection() {
    final bool isMobile = Responsive.isMobile(context);
    final years = ['2022年', '2023年', '2024年', '2025年', '2026年'];

    if (isMobile) {
      return Column(
        children: [
          // Year Selection: Back to Horizontal Scroller
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: years.map((year) {
                final isSel = _selectedFinancialYear == year;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFinancialYear = year),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSel
                          ? const Color(0xFF2F6FED)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(year,
                        style: TextStyle(
                            color:
                                isSel ? Colors.white : const Color(0xFF64748B),
                            fontSize: 12,
                            fontWeight:
                                isSel ? FontWeight.bold : FontWeight.normal)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          // Selected Year Data Card - High Density
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                _mobileMetricItem('销售额', '1200', '100%'),
                _mobileMetricItem('变动费', '480', '40%'),
                _mobileMetricItem('限界利益', '720', '60%', isHighlight: true),
                _mobileMetricItem('固定费', '520', '43%'),
                _mobileMetricItem('经营利益', '200', '17%', isHighlight: true),
                const Divider(height: 16),
                _mobileMetricItem('员工数', '120', '-', unit: '人'),
                _mobileMetricItem('人月生产性', '65', '-', unit: 'w'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildTrendChartCard(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: _buildFinancialTable()),
        const SizedBox(width: 32),
        Expanded(flex: 5, child: _buildTrendChartCard()),
      ],
    );
  }

  Widget _mobileMetricItem(String label, String value, String rate,
      {bool isHighlight = false, String unit = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 13,
                  color: isHighlight
                      ? const Color(0xFF1E293B)
                      : const Color(0xFF64748B),
                  fontWeight:
                      isHighlight ? FontWeight.bold : FontWeight.normal)),
          Row(
            children: [
              Text(value + unit,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B))),
              const SizedBox(width: 8),
              if (rate != '-')
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(rate,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialTable() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xFFCBD5E1))),
      child: Column(
        children: [
          _buildTableHeaderRow(),
          _buildMetricGroup(
              '损益指标',
              [
                _MetricRowData('销售额',
                    [1200, 100, 1350, 100, 1500, 100, 1680, 100, 1820, 100]),
                _MetricRowData(
                    '变动费', [480, 40, 510, 38, 540, 36, 580, 35, 620, 34]),
                _MetricRowData(
                    '限界利益', [720, 60, 840, 62, 960, 64, 1100, 65, 1200, 66]),
                _MetricRowData(
                    '固定费', [520, 43, 550, 41, 580, 39, 610, 36, 640, 35]),
                _MetricRowData(
                    '经营利益', [200, 17, 290, 21, 380, 25, 490, 29, 560, 31]),
              ],
              hasBottomBorder: true),
          _buildMetricGroup('管理指标', [
            _MetricRowData('员工数', [120, 0, 135, 0, 150, 0, 162, 0, 175, 0],
                isRateHidden: true),
            _MetricRowData('人月生产性', [65, 0, 72, 0, 78, 0, 84, 0, 92, 0],
                isRateHidden: true),
          ]),
        ],
      ),
    );
  }

  Widget _buildTableHeaderRow() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          color: Color(0xFFEDF2F7),
          border: Border(bottom: BorderSide(color: Color(0xFFCBD5E1)))),
      child: Row(
        children: [
          _buildHeaderCell('类型', width: 40),
          _buildHeaderCell('科目', width: 120),
          ...['2022年', '2023年', '2024年', '2025年', '2026年']
              .map((year) => Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text(year,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B))))),
                        const Divider(height: 1, color: Color(0xFFCBD5E1)),
                        const Row(
                          children: [
                            Expanded(
                                child: Center(
                                    child: Text('额',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF475569))))),
                            VerticalDivider(width: 1, color: Color(0xFFCBD5E1)),
                            Expanded(
                                child: Center(
                                    child: Text('率',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF475569))))),
                          ],
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {double? width}) {
    return Container(
      width: width,
      height: double.infinity,
      decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: Color(0xFFCBD5E1)))),
      child: Center(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B)))),
    );
  }

  Widget _buildMetricGroup(String type, List<_MetricRowData> rows,
      {bool hasBottomBorder = false}) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40.0 * rows.length,
          decoration: BoxDecoration(
            color: const Color(0xFFEDF2F7),
            border: Border(
              right: const BorderSide(color: Color(0xFFCBD5E1)),
              bottom: hasBottomBorder
                  ? const BorderSide(color: Color(0xFFCBD5E1))
                  : BorderSide.none,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: type
                  .split('')
                  .map((char) => Text(
                        char,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            color: Color(0xFF475569)),
                      ))
                  .toList(),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: rows
                .asMap()
                .entries
                .map((e) => _buildDataRowWithData(e.value,
                    indexInGroup: e.key,
                    isLast: e.key == rows.length - 1 && !hasBottomBorder))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDataRowWithData(_MetricRowData data,
      {required int indexInGroup, bool isLast = false}) {
    final bool isEven = indexInGroup % 2 == 0;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isEven ? Colors.white : const Color(0xFFF8FAFC),
        border: Border(
            bottom: isLast
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFCBD5E1))),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.only(left: 12),
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xFFCBD5E1)))),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(data.title,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.w500))),
          ),
          ...data.values.asMap().entries.map((entry) {
            final int index = entry.key;
            final double value = entry.value;
            final bool isRate = index % 2 != 0;
            String text = '';
            if (!(isRate && data.isRateHidden)) {
              text = isRate ? '${value.toInt()}%' : value.toStringAsFixed(0);
            }

            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      right: index == 9
                          ? BorderSide.none
                          : const BorderSide(color: Color(0xFFCBD5E1))),
                ),
                child: Center(
                    child: Text(text,
                        style: TextStyle(
                            fontSize: 11,
                            color: isRate
                                ? const Color(0xFF64748B)
                                : const Color(0xFF1E293B),
                            fontWeight:
                                isRate ? FontWeight.normal : FontWeight.bold))),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTrendChartCard() {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          const Text('经营指标趋势',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 32),
          const Expanded(child: _MetricComplexChart()),
          const SizedBox(height: 24),
          _buildChartLegend(),
        ],
      ),
    );
  }

  Widget _buildChartLegend() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        _legendItem('销售额', const Color(0xFF3B82F6), isCircle: false),
        _legendItem('限界利益', const Color(0xFFD1D5DB), isCircle: false),
        _legendItem('人均产出趋势', const Color(0xFFFACC15), isCircle: true),
      ],
    );
  }

  Widget _legendItem(String label, Color color, {required bool isCircle}) {
    return Row(
      children: [
        Container(
          width: isCircle ? 8 : 12,
          height: isCircle ? 8 : 12,
          decoration: BoxDecoration(
            color: color,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          '企业基本信息',
          actions: _isEditing
              ? [
                  _buildActionBtn('取消',
                      onTap: () => setState(() => _isEditing = false),
                      isOutline: true),
                  const SizedBox(width: 12),
                  _buildActionBtn('保存',
                      onTap: () => setState(() => _isEditing = false)),
                ]
              : [
                  _buildActionBtn('编辑资料',
                      onTap: () => setState(() => _isEditing = true),
                      isEdit: true),
                ],
        ),
        const SizedBox(height: 24),
        _buildDetailGrid([
          _DetailItem('企业简称:', ''),
          _DetailItem('企业注册名:', ''),
          _DetailItem('存续状态:', '', isDropdown: true),
          _DetailItem('统一社会信用代码:', '', isFullWidth: true),
          _DetailItem('区域:', '', isDropdown: true),
          _DetailItem('城市:', '', isDropdown: true),
          _DetailItem('行业:', '', isDropdown: true),
          _DetailItem('注册资本:', ''),
          _DetailItem('人员规模:', '', isDropdown: true),
          _DetailItem('法人代表:', ''),
          _DetailItem('联系人:', ''),
          _DetailItem('联系电话:', ''),
          _DetailItem('网站地址:', ''),
          _DetailItem('公司地址:', '', isFullWidth: true),
        ]),
        const SizedBox(height: 48),
        _buildSectionTitle('企业经营信息'),
        const SizedBox(height: 24),
        _buildDetailGrid([
          _DetailItem('事业描述:', '', isTextArea: true, isFullWidth: true),
          _DetailItem('事业数量:', ''),
          _DetailItem('品牌名称:', '', isTwoThirds: true),
          _DetailItem('关联公司:', ''),
          _DetailItem('交易价值:', ''),
          _DetailItem('服务等级:', '', isDropdown: true),
        ]),
        const SizedBox(height: 48),
        _buildSectionTitle('转介绍信息'),
        const SizedBox(height: 24),
        _buildDetailGrid([
          _DetailItem('转介绍类别:', '', isDropdown: true),
          _DetailItem('转介绍企业:', ''),
          _DetailItem('转介绍人:', ''),
          _DetailItem('转介绍企业顾客等级:', '', isDropdown: true),
          _DetailItem('转介绍人能力:', ''),
          _DetailItem('转介绍课程:', ''),
        ]),
      ],
    );
  }

  Widget _buildActionBtn(String label, {required VoidCallback onTap, bool isOutline = false, bool isEdit = false}) {
    if (isEdit) {
      return TextButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.edit_note, size: 18),
        label: Text(label),
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF2F6FED),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor: const Color(0xFFEFF6FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      );
    }

    if (isOutline) {
      return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF64748B),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      );
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2F6FED),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSectionTitle(String title, {List<Widget>? actions}) {
    return Row(
      children: [
        Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
                color: const Color(0xFF2F6FED),
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 12),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B))),
        const Spacer(),
        if (actions != null) ...actions,
      ],
    );
  }

  Widget _buildDetailGrid(List<_DetailItem> fields) {
    final bool isMobile = Responsive.isMobile(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double spacing = isMobile ? 12 : 24;
        final double runSpacing = _isEditing ? (isMobile ? 12 : 16) : (isMobile ? 20 : 32);

        final int columnCount = isMobile ? 2 : 3;
        final double itemWidth =
            (totalWidth - (spacing * (columnCount - 1))) / columnCount;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: fields.map((f) {
            double containerWidth;
            if (f.isFullWidth || (isMobile && f.isTwoThirds)) {
              containerWidth = totalWidth;
            } else if (f.isTwoThirds) {
              containerWidth = (itemWidth * 2) + spacing;
            } else {
              containerWidth = itemWidth;
            }

            final controller = _controllers[f.label];

            return SizedBox(
              width: containerWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                      fontWeight: _isEditing ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (_isEditing)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller,
                          maxLines: f.isTextArea ? 5 : 1,
                          style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: f.isTextArea ? 12 : 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFF2F6FED), width: 1.2),
                            ),
                            suffixIcon: f.isDropdown ? const Icon(Icons.expand_more, size: 18, color: Color(0xFF94A3B8)) : null,
                            suffixIconConstraints: const BoxConstraints(minWidth: 40),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: f.isTextArea ? 60 : 20),
                      child: Text(
                        controller?.text ?? f.value,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _MetricComplexChart extends StatelessWidget {
  const _MetricComplexChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _ComplexMetricPainter());
  }
}

class _ComplexMetricPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final gridPaint = Paint()
      ..color = const Color(0xFFF8FAFC)
      ..strokeWidth = 1;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    double pL = 30;
    double pB = 30;
    double cW = size.width - pL;
    double cH = size.height - pB;

    for (int i = 0; i <= 6; i++) {
      double y = cH - (cH / 6 * i);
      canvas.drawLine(Offset(pL, y), Offset(size.width, y), gridPaint);
      textPainter.text = TextSpan(
          text: '${i * 10}%',
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10));
      textPainter.layout();
      textPainter.paint(canvas, Offset(pL - 25, y - textPainter.height / 2));
    }

    final b1 = [0.72, 0.45, 0.65, 0.82];
    final b2 = [0.42, 0.78, 0.35, 0.55];
    final lineValues = [0.35, 0.35, 0.52, 0.90];
    double gW = cW / 4;
    double bW = 16;
    List<Offset> points = [];

    for (int i = 0; i < 4; i++) {
      double cX = pL + (gW * i) + (gW / 2);
      textPainter.text = TextSpan(
          text: '${2022 + i}年',
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 11));
      textPainter.layout();
      textPainter.paint(canvas, Offset(cX - textPainter.width / 2, cH + 10));

      paint.color = const Color(0xFF3B82F6);
      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromLTWH(cX - bW - 3, cH - (cH * b1[i]), bW, cH * b1[i]),
              topLeft: const Radius.circular(4),
              topRight: const Radius.circular(4)),
          paint);
      paint.color = const Color(0xFFD1D5DB);
      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromLTWH(cX + 3, cH - (cH * b2[i]), bW, cH * b2[i]),
              topLeft: const Radius.circular(4),
              topRight: const Radius.circular(4)),
          paint);
      points.add(Offset(cX, cH - (cH * lineValues[i])));
    }

    if (points.isNotEmpty) {
      final lP = Paint()
        ..color = const Color(0xFFFACC15)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      final path = Path();
      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 0; i < points.length - 1; i++) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.cubicTo(p0.dx + (p1.dx - p0.dx) / 2, p0.dy,
            p0.dx + (p1.dx - p0.dx) / 2, p1.dy, p1.dx, p1.dy);
      }
      canvas.drawPath(path, lP);
      final dP = Paint()..color = const Color(0xFFFACC15);
      final bP = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      for (var p in points) {
        canvas.drawCircle(p, 5, dP);
        canvas.drawCircle(p, 5, bP);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) => true;
}

class _DetailItem {
  final String label;
  final String value;
  final bool isTextArea;
  final bool isFullWidth;
  final bool isTwoThirds;
  final bool isDropdown;

  _DetailItem(
    this.label,
    this.value, {
    this.isTextArea = false,
    this.isFullWidth = false,
    this.isTwoThirds = false,
    this.isDropdown = false,
  });
}

/// Landscape/mountain image placeholder painter used in 影像资料
class _LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Sky background
    canvas.drawRect(
        Offset.zero & size, Paint()..color = const Color(0xFF5BA4F5));
    // Sun
    canvas.drawCircle(
      Offset(size.width * 0.22, size.height * 0.28),
      size.width * 0.09,
      Paint()..color = const Color(0xFF90C4FF),
    );
    // Back mountain
    final back = Path()
      ..moveTo(size.width * 0.28, size.height)
      ..lineTo(size.width * 0.60, size.height * 0.28)
      ..lineTo(size.width * 1.05, size.height)
      ..close();
    canvas.drawPath(back, Paint()..color = const Color(0xFF3A82E0));
    // Front mountain
    final front = Path()
      ..moveTo(-size.width * 0.05, size.height)
      ..lineTo(size.width * 0.36, size.height * 0.42)
      ..lineTo(size.width * 0.72, size.height)
      ..close();
    canvas.drawPath(front, Paint()..color = const Color(0xFF2F6FED));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
