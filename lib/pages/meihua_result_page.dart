// lib/pages/meihua_result_page.dart
import 'package:flutter/material.dart';

/// 梅花易数排盘结果页
class MeiHuaResultPage extends StatelessWidget {
  final String title;
  final String querySubject;
  // 模拟传入的梅花排盘数据（实际开发中可传入数据模型对象）
  final String benGuaName;    // 本卦，如：天风姤
  final String huGuaName;     // 互卦，如：重乾
  final String bianGuaName;   // 变卦，如：巽为风
  final int dongYao;          // 动爻位置：1-6
  final String tiGua;         // 体卦，如：乾(金)
  final String yongGua;       // 用卦，如：巽(木)
  final String shengKeResult; // 生克结论，如：体克用 (吉)

  const MeiHuaResultPage({
    super.key,
    required this.title,
    required this.querySubject,
    this.benGuaName = '天风姤',
    this.huGuaName = '乾为天',
    this.bianGuaName = '巽为风',
    this.dongYao = 1,
    this.tiGua = '乾金 (上卦)',
    this.yongGua = '巽木 (下卦)',
    this.shengKeResult = '体克用（吉，主事可成但需费力）',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: const Color(0xFF8B261D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildTimeHeader(),
              const SizedBox(height: 12),
              _buildThreeGuaCard(),
              const SizedBox(height: 12),
              _buildTiYongAnalysisCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// 头部时间与起卦信息
  Widget _buildTimeHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDCD6CD)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('丙午年', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('丁酉月', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('丙子日', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('甲午时', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('动爻：初爻动（第 $dongYao 爻）',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
              const Text('卦气：秋金当旺', style: TextStyle(color: Colors.black54, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  /// 主卦、互卦、变卦三大核心对比区
  Widget _buildThreeGuaCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDCD6CD)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGuaColumn('主 卦', benGuaName, [1, 1, 1, 1, 1, 0], dongYaoIndex: dongYao - 1, isMain: true),
              const ContainerDivider(),
              _buildGuaColumn('互 卦', huGuaName, [1, 1, 1, 1, 1, 1]),
              const ContainerDivider(),
              _buildGuaColumn('变 卦', bianGuaName, [1, 1, 1, 1, 1, 1]),
            ],
          ),
        ],
      ),
    );
  }

  /// 单个卦象列（上卦 + 下卦 + 爻画 + 体用标注）
  Widget _buildGuaColumn(String label, String guaName, List<int> yaos, {int? dongYaoIndex, bool isMain = false}) {
    // yaos 从下到上：0表示阴爻，1表示阳爻
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(guaName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
        const SizedBox(height: 10),
        // 渲染 6 个爻画（自上而下绘制上爻到初爻）
        ...List.generate(6, (index) {
          int yaoPos = 5 - index; // 5是上爻，0是初爻
          bool isYang = yaos[yaoPos] == 1;
          bool isDong = (dongYaoIndex != null && dongYaoIndex == yaoPos);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildYaoLine(isYang: isYang, isDong: isDong),
                if (isDong)
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text('●', style: TextStyle(color: Colors.red, fontSize: 10)),
                  ),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
        if (isMain)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF8B261D).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('体上 用下', style: TextStyle(fontSize: 11, color: Color(0xFF8B261D), fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }

  /// 绘制单个阴爻/阳爻图形
  Widget _buildYaoLine({required bool isYang, required bool isDong}) {
    final Color color = isDong ? Colors.red : const Color(0xFF2C3E50);

    return SizedBox(
      width: 42,
      height: 10,
      child: isYang
          ? Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(1)))
          : Row(
        children: [
          Expanded(child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(1)))),
          const SizedBox(width: 6),
          Expanded(child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(1)))),
        ],
      ),
    );
  }

  /// 体用生克与断卦参考卡片
  Widget _buildTiYongAnalysisCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDCD6CD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('【体用分析】', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
          const SizedBox(height: 8),
          _buildInfoRow('体卦（代表自己/主体）：', tiGua),
          _buildInfoRow('用卦（代表所占之事/客体）：', yongGua),
          _buildInfoRow('五行生克关系：', shengKeResult),
          const Divider(height: 16),
          const Text('【断卦吉凶提示】', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            '• 比和 / 体生用：吉利，谋事易成。\n'
                '• 体克用：吉，虽然可成但过程需付出努力。\n'
                '• 用克体：大凶，受制于人或遭遇阻碍。\n'
                '• 体生用：耗损，付出多回报少。',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

/// 垂直分割线辅助组件
class ContainerDivider extends StatelessWidget {
  const ContainerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 1,
      color: const Color(0xFFE5E0D8),
    );
  }
}