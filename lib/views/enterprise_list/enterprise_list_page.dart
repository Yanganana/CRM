import 'package:flutter/material.dart';
import 'package:consultant_crm/utils/responsive.dart';

class EnterpriseListPage extends StatefulWidget {
  final VoidCallback onDetailRequested;

  const EnterpriseListPage({super.key, required this.onDetailRequested});

  @override
  State<EnterpriseListPage> createState() => _EnterpriseListPageState();
}

class _EnterpriseListPageState extends State<EnterpriseListPage> {
  bool _isAdvancedFilterOpen = false;

  final List<Map<String, String>> _mockData = [
    {
      'id': '1',
      'name': '赢家时尚控股有限公司',
      'industry': '中高端女装',
      'level': 'V类',
      'region': '华南·深圳',
      'total': '¥81.20万',
      'status': '进行中',
      'staff': '祝菲菲'
    },
    {
      'id': '2',
      'name': '华为技术有限公司',
      'industry': 'IT/通信',
      'level': 'V类',
      'region': '华南·东莞',
      'total': '¥45.00万',
      'status': '进行中',
      'staff': '陈大文'
    },
    {
      'id': '3',
      'name': '招商银行',
      'industry': '金融业',
      'level': 'A类',
      'region': '华南·深圳',
      'total': '¥12.50万',
      'status': '已签约',
      'staff': '李小宝'
    },
    {
      'id': '4',
      'name': '万科企业',
      'industry': '房地产业',
      'level': 'A类',
      'region': '华南·深圳',
      'total': '¥33.00万',
      'status': '进行中',
      'staff': '祝菲菲'
    },
    {
      'id': '5',
      'name': '腾讯控股',
      'industry': '互联网',
      'level': 'V类',
      'region': '华南·深圳',
      'total': '¥99.90万',
      'status': '进行中',
      'staff': '王小虎'
    },
    {
      'id': '6',
      'name': '比亚迪',
      'industry': '汽车制造',
      'level': 'B类',
      'region': '华南·深圳',
      'total': '¥21.00万',
      'status': '进行中',
      'staff': '陈大文'
    },
    {
      'id': '7',
      'name': '大疆创新',
      'industry': '智能硬件',
      'level': 'B类',
      'region': '华南·深圳',
      'total': '¥15.00万',
      'status': '已完成',
      'staff': '李小宝'
    },
    {
      'id': '8',
      'name': '顺丰控股',
      'industry': '物流运输',
      'level': 'C类',
      'region': '华南·深圳',
      'total': '¥8.20万',
      'status': '进行中',
      'staff': '祝菲菲'
    },
    {
      'id': '9',
      'name': '阿里巴巴',
      'industry': '电子商务',
      'level': 'V类',
      'region': '华东·杭州',
      'total': '¥62.30万',
      'status': '进行中',
      'staff': '王小虎'
    },
    {
      'id': '10',
      'name': '美团',
      'industry': '生活服务',
      'level': 'A类',
      'region': '华北·北京',
      'total': '¥28.40万',
      'status': '进行中',
      'staff': '祝菲菲'
    },
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
                '企业列表',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement add enterprise logic
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  '新增企业',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6FED),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildQuickSearchRow(),
          if (_isAdvancedFilterOpen) ...[
            const SizedBox(height: 16),
            _buildAdvancedFilterGrid(),
          ],
          const SizedBox(height: 24),
          Expanded(child: _buildTableCard()),
        ],
      ),
    );
  }

  Widget _buildQuickSearchRow() {
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
                child: const Icon(Icons.search,
                    size: 20, color: Color(0xFF2F6FED)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '按名称、行业或区域搜索...',
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
            onPressed: () =>
                setState(() => _isAdvancedFilterOpen = !_isAdvancedFilterOpen),
            icon: Icon(
              _isAdvancedFilterOpen ? Icons.filter_list_off : Icons.filter_list,
              size: 20,
              color: const Color(0xFF2F6FED),
            ),
            tooltip: '高级筛选',
          ),
          if (!isMobile)
            TextButton(
              onPressed: () => setState(
                  () => _isAdvancedFilterOpen = !_isAdvancedFilterOpen),
              child: Text(
                _isAdvancedFilterOpen ? '简单筛选' : '高级筛选',
                style: const TextStyle(
                    color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAdvancedFilterGrid() {
    final bool isMobile = Responsive.isMobile(context);
    return Container(
      constraints: isMobile ? const BoxConstraints(maxHeight: 320) : null,
      padding: EdgeInsets.all(isMobile ? 12 : 24),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 16,
                runSpacing: isMobile ? 10 : 20,
                children: [
                  _buildFilterItem('企业名:', '请输入名称', isInput: true),
                  _buildFilterItem('行业类别:', '全部行业'),
                  _buildFilterItem('学员姓名:', '请输入姓名', isInput: true),
                  _buildFilterItem('所属区域:', '全部区域'),
                  _buildFilterItem('所在城市:', '全部城市'),
                  _buildFilterItem('担当前员:', '全部人员'),
                  _buildFilterItem('课程系列:', '全部系列'),
                  _buildFilterItem('课程期数:', '全部期数'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6FED),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text('执行筛选',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => setState(() => _isAdvancedFilterOpen = false),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                child: const Text('重置条件',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
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
          SizedBox(
              width: 70,
              child: Text(label,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF64748B)))),
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
                  Expanded(
                      child: Text(hint,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF94A3B8)))),
                  if (!isInput)
                    const Icon(Icons.keyboard_arrow_down,
                        size: 16, color: Color(0xFF94A3B8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCard() {
    final bool isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _mockData.length,
              itemBuilder: (context, index) {
                final item = _mockData[index];
                return _buildEnterpriseCard(
                    item['name']!,
                    item['industry']!,
                    item['level']!,
                    item['region']!,
                    item['total']!,
                    item['status']!,
                    item['staff']!);
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
                itemCount: _mockData.length,
                itemBuilder: (context, index) {
                  final item = _mockData[index];
                  return _buildTableRow(
                      item['id']!,
                      item['name']!,
                      item['industry']!,
                      item['level']!,
                      item['region']!,
                      item['total']!,
                      item['status']!,
                      item['staff']!);
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

  Widget _buildEnterpriseCard(String name, String industry, String level,
      String region, String total, String status, String staff) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B))),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == '已签约'
                      ? const Color(0xFFF0FDF4)
                      : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(status,
                    style: TextStyle(
                        fontSize: 11,
                        color: status == '已签约'
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF2F6FED),
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildInfoTag(Icons.business_outlined, industry),
              _buildInfoTag(Icons.location_on_outlined, region),
              _buildInfoTag(Icons.person_outline, staff),
            ],
          ),
          const Divider(height: 24, color: Color(0xFFF1F5F9)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('总消费额',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  const SizedBox(height: 4),
                  Text(total,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                ],
              ),
              ElevatedButton(
                onPressed: widget.onDetailRequested,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6FED).withOpacity(0.1),
                  foregroundColor: const Color(0xFF2F6FED),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('查看详情',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: const Row(
        children: [
          Expanded(flex: 3, child: Text('企业简称', style: _hStyle)),
          Expanded(
              flex: 2,
              child: Text('行业', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(
              flex: 1,
              child: Text('等级', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(
              flex: 2,
              child: Text('区域', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(
              flex: 2,
              child: Text('总消费额', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(
              flex: 2,
              child: Text('状态', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(
              flex: 1,
              child: Text('担当人员', style: _hStyle, textAlign: TextAlign.center)),
          Expanded(
              flex: 1,
              child: Text('操作', style: _hStyle, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  static const TextStyle _hStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B));

  Widget _buildTableRow(String id, String name, String industry, String level,
      String region, String total, String status, String staff) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B)))),
          Expanded(
              flex: 2,
              child: Text(industry,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  textAlign: TextAlign.center)),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: 44,
                padding: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(level,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFF43F5E),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(region,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  textAlign: TextAlign.center)),
          Expanded(
              flex: 2,
              child: Text(total,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B)),
                  textAlign: TextAlign.center)),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                width: 64,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(status,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF16A34A),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Text(staff,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  textAlign: TextAlign.center)),
          Expanded(
            flex: 1,
            child: Center(
              child: TextButton(
                onPressed: widget.onDetailRequested,
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: const Text('查看详情',
                    style: TextStyle(fontSize: 13, color: Color(0xFF2F6FED))),
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
        const Text('第 1 到 10 条，共 3013 条',
            style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_left,
                size: 20, color: Color(0xFF94A3B8))),
        const Text('1 / 302',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B))),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right,
                size: 20, color: Color(0xFF1E293B))),
      ],
    );
  }
}
