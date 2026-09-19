import 'package:flutter/material.dart';

/// 单爻数据模型
class LiuYaoLineData {
  final String positionName;
  final bool isYang;
  final String liuQin;
  final String ganZhi;
  final String beast;

  final bool isDongYao;
  final bool isShiYao;
  final bool isYingYao;

  final bool bianIsYang;
  final String bianLiuQin;
  final String bianGanZhi;

  LiuYaoLineData({
    required this.positionName,
    required this.isYang,
    required this.liuQin,
    required this.ganZhi,
    required this.beast,
    this.isDongYao = false,
    this.isShiYao = false,
    this.isYingYao = false,
    required this.bianIsYang,
    required this.bianLiuQin,
    required this.bianGanZhi,
  });
}

class LiuYaoResultPage extends StatelessWidget {
  final String title;
  final String querySubject;

  // ----------------【时间与干支属性】----------------
  final String guaTime;      // 公历时间 + 地支时辰
  final String yearGanZhi;   // 年柱
  final String monthGanZhi;  // 月柱
  final String dayGanZhi;    // 日柱
  final String hourGanZhi;   // 时柱 (新增)
  final String xunKong;      // 旬空 (空亡)

  final String benGuaName;
  final String benGuaGong;
  final String bianGuaName;

  final List<LiuYaoLineData> lines;

  const LiuYaoResultPage({
    super.key,
    required this.title,
    required this.querySubject,
    this.guaTime = '2026-09-19 14:30 (未时)',
    this.yearGanZhi = '丙午年',
    this.monthGanZhi = '丁酉月',
    this.dayGanZhi = '丙申日',
    this.hourGanZhi = '乙未时',
    this.xunKong = '辰巳',
    required this.benGuaName,
    required this.benGuaGong,
    required this.bianGuaName,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF8B261D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // 1. 顶部基本信息卡片（优化了干支与空亡排版，防止溢出）
              _buildHeaderCard(),
              const SizedBox(height: 12),
              // 2. 六爻排盘主卡片
              _buildMainPanCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// 顶部基本信息卡片
  Widget _buildHeaderCard() {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 占测事项
            Row(
              children: [
                const Text('占事：', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
                Expanded(
                  child: Text(
                    querySubject,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const Divider(height: 16),

            // 1. 起卦时间（包含具体时分及地支时辰）
            Row(
              children: [
                const Icon(Icons.access_time, size: 15, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('时间：', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Expanded(
                  child: Text(
                    guaTime,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // 2. 干支四柱（含年、月、日、时四柱）
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, size: 15, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('干支：', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Expanded(
                  child: Text(
                    '$yearGanZhi  $monthGanZhi  $dayGanZhi  $hourGanZhi',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF8B261D)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // 3. 旬空/空亡（独立成行，防窄屏溢出）
            Row(
              children: [
                const Icon(Icons.blur_on, size: 15, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('空亡：', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(
                  xunKong,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey.shade800),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 六爻排盘主表
  Widget _buildMainPanCard() {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 卦名标题头
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('本卦：$benGuaName ($benGuaGong)', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
                const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                Text('变卦：$bianGuaName', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
            const Divider(height: 20),
            // 6 个爻位渲染
            ...lines.map((line) => _buildYaoRow(line)),
          ],
        ),
      ),
    );
  }

  /// 单爻数据渲染行
  Widget _buildYaoRow(LiuYaoLineData line) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // 六兽
          SizedBox(
            width: 32,
            child: Text(line.beast, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          ),
          // 本卦六亲 + 纳甲干支
          SizedBox(
            width: 76,
            child: Row(
              children: [
                Text(line.liuQin, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(width: 2),
                Text(line.ganZhi, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          // 本卦爻象 (阴爻/阳爻)
          Expanded(child: _buildYaoSymbol(line.isYang)),

          // 动爻 / 世应 标记
          SizedBox(
            width: 32,
            child: Center(
              child: Text(
                line.isDongYao ? '◯' : (line.isShiYao ? '世' : (line.isYingYao ? '应' : '')),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: line.isDongYao ? Colors.red : const Color(0xFF8B261D),
                ),
              ),
            ),
          ),

          // 变卦爻象（去掉 isDongYao 判断，永远显示变卦爻符）
          Expanded(child: _buildYaoSymbol(line.bianIsYang)),

          // 变卦六亲 + 纳甲干支（去掉隐藏判断，但动爻用红色高亮，静爻用灰色）
          SizedBox(
            width: 76,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    line.bianLiuQin,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        // 动爻变出来的六亲用红色，没动的保持正常颜色
                        color: line.isDongYao ? Colors.red : Colors.grey.shade700
                    )
                ),
                const SizedBox(width: 2),
                Text(
                    line.bianGanZhi,
                    style: TextStyle(
                        fontSize: 12,
                        // 动爻变出来的干支用红色，没动的用浅灰色
                        color: line.isDongYao ? Colors.red : Colors.grey
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 绘制爻符 (阳爻 ━━━ / 阴爻 ━ ━)
  Widget _buildYaoSymbol(bool isYang) {
    if (isYang) {
      return Container(
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF8B261D),
          borderRadius: BorderRadius.circular(2),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B261D),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B261D),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}