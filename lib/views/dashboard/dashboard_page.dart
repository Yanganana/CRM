import 'package:flutter/material.dart';
import 'package:consultant_crm/utils/responsive.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedBusiness = '全体';
  String _selectedDimension = '今年';

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterSection(),
          const SizedBox(height: 24),
          _buildKpiRow(),
          const SizedBox(height: 24),
          _buildChartRow1(),
          const SizedBox(height: 24),
          _buildChartRow2(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    final bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
                _buildFilterGroup('业务归属', ['全体', '我部门的', '我负责的'],
                    _selectedBusiness, (val) {
                  setState(() => _selectedBusiness = val);
                }),
                const SizedBox(height: 16),
                _buildFilterGroup('统计维度', ['今年', '去年', '本季度', '上季度', '本月', '上月'],
                    _selectedDimension, (val) {
                  setState(() => _selectedDimension = val);
                }),
              ],
            )
          : Wrap(
              spacing: 32,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildFilterGroup('业务归属', ['全体', '我部门的', '我负责的'],
                    _selectedBusiness, (val) {
                  setState(() => _selectedBusiness = val);
                }),
                _buildFilterGroup('统计维度', ['今年', '去年', '本季度', '上季度', '本月', '上月'],
                    _selectedDimension, (val) {
                  setState(() => _selectedDimension = val);
                }),
              ],
            ),
    );
  }

  Widget _buildFilterGroup(String label, List<String> options, String selected,
      Function(String) onSelect) {
    final bool isMobile = Responsive.isMobile(context);

    final labelWidget = Text(label,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B)));

    final chipsWidget = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: options.map((opt) {
            final bool isSelected = opt == selected;
            return GestureDetector(
              onTap: () => onSelect(opt),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 10 : 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
    );

    return isMobile
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelWidget,
                const SizedBox(height: 10),
                chipsWidget,
              ],
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              labelWidget,
              const SizedBox(width: 16),
              chipsWidget,
            ],
          );
  }

  Widget _buildKpiRow() {
    final bool isMobile = Responsive.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Safe width calculation using LayoutBuilder constraints
        const double spacing = 16.0;
        final double itemWidth = isMobile
            ? (constraints.maxWidth - spacing) / 2
            : (constraints.maxWidth - (spacing * 4)) / 5;

        // Ensure width is never negative
        final double safeWidth = itemWidth > 0 ? itemWidth : 1.0;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            SizedBox(
                width: safeWidth,
                child: const _KpiCard(
                    title: '企业总数', value: '3013', color: Color(0xFF2F6FED))),
            SizedBox(
                width: safeWidth,
                child: const _KpiCard(
                    title: '学员总数', value: '6212', color: Color(0xFF1E293B))),
            SizedBox(
                width: safeWidth,
                child: const _KpiCard(
                    title: '新增企业数', value: '121', color: Color(0xFF10B981))),
            SizedBox(
                width: safeWidth,
                child: const _KpiCard(
                    title: '新顾客录入',
                    value: '312',
                    color: Color(0xFFF59E0B),
                    showArrow: true)),
            SizedBox(
                width: safeWidth,
                child: const _KpiCard(
                    title: '顾客信息补充', value: '532', color: Color(0xFF8B5CF6))),
          ],
        );
      },
    );
  }

  Widget _buildChartRow1() {
    final bool isMobile = Responsive.isMobile(context);
    final items = [
      const _ChartCard(title: '顾客服务等级占比', child: _ServiceLevelDonut()),
      const _ChartCard(title: '转介绍顾客成交比', child: _MockBarChart()),
      const _ChartCard(title: '新顾客来源推移', child: _MockStackedBarChart()),
    ];

    if (isMobile) {
      return Column(
        children: items
            .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(height: 400, child: item)))
            .toList(),
      );
    }

    return SizedBox(
      height: 420,
      child: Row(
        children: items
            .map((item) => Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.only(right: item == items.last ? 0 : 24),
                    child: item)))
            .toList(),
      ),
    );
  }

  Widget _buildChartRow2() {
    final bool isMobile = Responsive.isMobile(context);
    const chart1 = _ChartCard(title: '顾客地域分布', child: _ChinaProvinceMap());
    const chart2 = _ChartCard(title: '顾客行业分布', child: _IndustryPieMock());

    if (isMobile) {
      return const Column(
        children: [
          SizedBox(height: 480, child: chart1),
          SizedBox(height: 24),
          SizedBox(height: 520, child: chart2),
        ],
      );
    }

    return const SizedBox(
      height: 480,
      child: Row(
        children: [
          Expanded(flex: 3, child: chart1),
          SizedBox(width: 24),
          Expanded(flex: 2, child: chart2),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final bool showArrow;

  const _KpiCard(
      {required this.title,
      required this.value,
      required this.color,
      this.showArrow = false});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 16),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
                const SizedBox(width: 4),
                if (showArrow)
                  Icon(Icons.north, size: isMobile ? 20 : 24, color: color)
                else
                  Text('家',
                      style: TextStyle(
                          fontSize: 12,
                          color: color.withOpacity(0.6),
                          fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 24),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ServiceLevelDonut extends StatelessWidget {
  const _ServiceLevelDonut();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: CustomPaint(
              size: const Size(180, 180),
              painter: _ServiceLevelPainter(),
            ),
          ),
        ),
        const SizedBox(width: 24),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LargeLegendItem('A类重点', Color(0xFFF59E0B)),
            SizedBox(height: 12),
            _LargeLegendItem('B类普通', Color(0xFF10B981)),
            SizedBox(height: 12),
            _LargeLegendItem('C类潜在', Color(0xFFEF4444)),
            SizedBox(height: 12),
            _LargeLegendItem('V类核心', Color(0xFF3B82F6)),
          ],
        ),
      ],
    );
  }
}

class _LargeLegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LargeLegendItem(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}

class _ServiceLevelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;
    final strokeWidth = size.width * 0.16;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final List<Map<String, dynamic>> data = [
      {'val': 0.35, 'color': const Color(0xFF3B82F6)}, // V类核心
      {'val': 0.20, 'color': const Color(0xFFF59E0B)}, // A类重点
      {'val': 0.30, 'color': const Color(0xFF10B981)}, // B类普通
      {'val': 0.15, 'color': const Color(0xFFEF4444)}, // C类潜在
    ];

    double startAngle = -1.57; // Start from top
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    for (var item in data) {
      final sweepAngle = (item['val'] as double) * 6.28;
      paint.color = item['color'] as Color;
      // Drawing with gaps as shown in prototype
      canvas.drawArc(rect, startAngle + 0.05, sweepAngle - 0.1, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProvinceData {
  final String name;
  final int count;
  _ProvinceData(this.name, this.count);
}

class _ChinaProvinceMap extends StatefulWidget {
  const _ChinaProvinceMap();
  @override
  State<_ChinaProvinceMap> createState() => _ChinaProvinceMapState();
}

class _ChinaProvinceMapState extends State<_ChinaProvinceMap> {
  late MapShapeSource _shapeSource;
  bool _isLoading = true;

  final List<_ProvinceData> _data = [
    _ProvinceData('江苏省', 42),
    _ProvinceData('河北省', 6),
    _ProvinceData('广东省', 18),
    _ProvinceData('浙江省', 12),
    _ProvinceData('山东省', 9),
    _ProvinceData('北京市', 5),
  ];

  @override
  void initState() {
    super.initState();
    _shapeSource = MapShapeSource.asset(
      'assets/china.json',
      shapeDataField: 'name',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].name,
      shapeColorValueMapper: (int index) => _data[index].count.toDouble(),
      shapeColorMappers: [
        const MapColorMapper(from: 0, to: 42, color: Color(0xFF3B82F6)),
      ],
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('42',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 4),
            Container(
              width: 8,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.blue[600]!, Colors.blue[50]!],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 4),
            const Text('0', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        Expanded(
          child: SfMaps(
            layers: [
              MapShapeLayer(
                source: _shapeSource,
                color: const Color(0xFFF1F5F9),
                strokeColor: Colors.white,
                strokeWidth: 0.5,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _data[index].name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '顾客数: ${_data[index].count}人',
                          style: const TextStyle(
                              color: Color(0xFF94A3B8), fontSize: 11),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MockBarChart extends StatelessWidget {
  const _MockBarChart();
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _BarSet(h1: 140, h2: 90, label: '顾问推荐'),
              _BarSet(h1: 110, h2: 40, label: '学员推荐'),
            ],
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _LegendItem('成交数量', Color(0xFFF59E0B)),
            _LegendItem('推荐数量', Color(0xFF3B82F6)),
          ],
        ),
      ],
    );
  }
}

class _BarSet extends StatelessWidget {
  final double h1, h2;
  final String label;
  const _BarSet({required this.h1, required this.h2, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: 24,
                height: h1,
                decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(4))),
            const SizedBox(width: 4),
            Container(
                width: 24,
                height: h2,
                decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B),
                    borderRadius: BorderRadius.circular(4))),
          ],
        ),
        const SizedBox(height: 12),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
      ],
    );
  }
}

class _MockStackedBarChart extends StatelessWidget {
  const _MockStackedBarChart();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
                6,
                (i) => Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 18,
                            height: 30 + (i % 3) * 15,
                            color: const Color(0xFFF59E0B),
                            margin: const EdgeInsets.only(bottom: 2)),
                        Container(
                            width: 18,
                            height: 25 + (i % 2) * 10,
                            color: const Color(0xFF10B981),
                            margin: const EdgeInsets.only(bottom: 2)),
                        Container(
                            width: 18,
                            height: 40 + (i % 4) * 8,
                            color: const Color(0xFF3B82F6)),
                        const SizedBox(height: 12),
                        Text('${i + 1}月',
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF64748B))),
                      ],
                    )),
          ),
        ),
        const Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _LegendItem('活动转化', Color(0xFF3B82F6)),
            _LegendItem('自主开发', Color(0xFF10B981)),
            _LegendItem('转介绍', Color(0xFFF59E0B)),
          ],
        ),
      ],
    );
  }
}

class _IndustryPieMock extends StatelessWidget {
  const _IndustryPieMock();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(200, 200),
                painter: _IndustryDonutPainter(),
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('行业总数',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text('115',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Builder(builder: (context) {
          final bool isMobile = Responsive.isMobile(context);
          final List<Widget> legends = [
            const _LegendRow('服装品牌', '27.0%', Color(0xFF3B82F6)),
            const _LegendRow('制造行业', '15.7%', Color(0xFFF59E0B)),
            const _LegendRow('IT/互联网', '15.7%', Color(0xFF10B981)),
            const _LegendRow('金融业', '10.4%', Color(0xFFEF4444)),
            const _LegendRow('交通运输', '10.4%', Color(0xFF8B5CF6)),
            const _LegendRow('房地产业', '5.2%', Color(0xFF6366F1)),
            const _LegendRow('建筑业', '5.2%', Color(0xFF60A5FA)),
            const _LegendRow('其他', '10.4%', Color(0xFFFDBA74)),
          ];

          if (isMobile) {
            return Column(
              children: legends
                  .map((l) => Padding(
                      padding: const EdgeInsets.only(bottom: 8), child: l))
                  .toList(),
            );
          }

          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    legends[0],
                    const SizedBox(height: 12),
                    legends[2],
                    const SizedBox(height: 12),
                    legends[4],
                    const SizedBox(height: 12),
                    legends[6],
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  children: [
                    legends[1],
                    const SizedBox(height: 12),
                    legends[3],
                    const SizedBox(height: 12),
                    legends[5],
                    const SizedBox(height: 12),
                    legends[7],
                  ],
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  final String label;
  final String percentage;
  final Color color;

  const _LegendRow(this.label, this.percentage, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500)),
        ),
        Text(percentage,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _IndustryDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;
    final strokeWidth = size.width * 0.16;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final List<Map<String, dynamic>> data = [
      {'val': 0.27, 'color': const Color(0xFF3B82F6)}, // 服装
      {'val': 0.157, 'color': const Color(0xFFF59E0B)}, // 制造
      {'val': 0.157, 'color': const Color(0xFF10B981)}, // IT
      {'val': 0.104, 'color': const Color(0xFFEF4444)}, // 金融
      {'val': 0.104, 'color': const Color(0xFF8B5CF6)}, // 交通
      {'val': 0.104, 'color': const Color(0xFFFDBA74)}, // 其他
      {'val': 0.052, 'color': const Color(0xFF6366F1)}, // 房产
      {'val': 0.052, 'color': const Color(0xFF60A5FA)}, // 建筑
    ];

    double startAngle = -1.57; // Start from top
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    for (var item in data) {
      final sweepAngle = (item['val'] as double) * 6.28;
      paint.color = item['color'] as Color;
      // Draw with tiny gaps if needed, but butt cap joins are cleaner
      canvas.drawArc(rect, startAngle + 0.02, sweepAngle - 0.04, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendItem(this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
