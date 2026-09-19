import 'package:flutter/material.dart';
import 'liuyao_result_page.dart';

/// 爻类型定义
enum YaoType {
  shaoYang, // 少阳 (单/阳 ━━━)
  shaoYin,  // 少阴 (拆/阴 ━ ━)
  laoYang,  // 老阳 (重/阳动 ━━━ ◯)
  laoYin,   // 老阴 (交/阴动 ━ ━ ✕)
}

class ManualLiuYaoPage extends StatefulWidget {
  const ManualLiuYaoPage({super.key});

  @override
  State<ManualLiuYaoPage> createState() => _ManualLiuYaoPageState();
}

class _ManualLiuYaoPageState extends State<ManualLiuYaoPage> {
  // 1. 占测事项控制器
  final TextEditingController _subjectController = TextEditingController(text: '测近来运势');

  // 2. 六爻选择状态（index 0 为初爻，index 5 为上爻，默认设定为少阳）
  final List<YaoType> _selectedYaos = List.generate(6, (_) => YaoType.shaoYang);

  // 爻位名称（从初爻至上爻）
  final List<String> _positionNames = ['初爻', '二爻', '三爻', '四爻', '五爻', '上爻'];

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  /// 转换数据并跳转至排盘结果页
  void _submitAndNavigate() {
    final String subject = _subjectController.text.trim().isEmpty
        ? '未填写事项'
        : _subjectController.text.trim();

    final List<LiuYaoLineData> linesData = [];
    final List<String> beasts = ['玄武', '青龙', '朱雀', '勾陈', '螣蛇', '白虎'];
    final List<String> liuQins = ['父母', '兄弟', '官鬼', '兄弟', '官鬼', '妻财'];
    final List<String> ganZhis = ['戌土', '申金', '午火', '辰土', '寅木', '子水'];

    // 从上爻(i = 5)向下处理至初爻(i = 0)
    for (int i = 5; i >= 0; i--) {
      final yao = _selectedYaos[i];
      final bool isYang = (yao == YaoType.shaoYang || yao == YaoType.laoYang);
      final bool isDong = (yao == YaoType.laoYang || yao == YaoType.laoYin);
      final bool bianYang = isDong ? !isYang : isYang;

      linesData.add(
        LiuYaoLineData(
          positionName: _positionNames[i],
          isYang: isYang,
          liuQin: liuQins[5 - i],
          ganZhi: ganZhis[5 - i],
          beast: beasts[5 - i],
          isDongYao: isDong,
          isShiYao: i == 4,
          isYingYao: i == 1,
          bianIsYang: bianYang,
          bianLiuQin: isDong ? (isYang ? '妻财' : '官鬼') : liuQins[5 - i],
          bianGanZhi: isDong ? '未土' : ganZhis[5 - i],
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiuYaoResultPage(
          title: '六爻排盘详情',
          querySubject: subject,
          guaTime: '2026-09-19 14:30 (未时)', // 👈 带具体时辰
          yearGanZhi: '丙午年',
          monthGanZhi: '丁酉月',
          dayGanZhi: '丙申日',
          hourGanZhi: '乙未时',               // 👈 四柱加入时柱
          xunKong: '辰巳',
          benGuaName: '手动起卦',
          benGuaGong: '乾宫',
          bianGuaName: '变卦',
          lines: linesData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: const Text('手动起卦'),
        backgroundColor: const Color(0xFF8B261D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------【1. 占测事项输入框】----------------
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.edit_note, color: Color(0xFF8B261D), size: 20),
                          SizedBox(width: 4),
                          Text(
                            '占测事项',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF8B261D)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _subjectController,
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: '点击输入占测事项（如：求财、看婚姻、问事业）',
                          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor: const Color(0xFFF9F9F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Color(0xFF8B261D)),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () => _subjectController.clear(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ----------------【2. 六爻下拉选择卡片】----------------
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '手动选爻（从上爻至初爻）',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      const Text('通过下拉框快速设置各爻阴阳动静', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const Divider(height: 16),
                      // 渲染 6 个下拉框（从上爻到初爻）
                      ...List.generate(6, (index) {
                        final yaoIndex = 5 - index; // 最上面显示上爻
                        return _buildYaoDropdownRow(yaoIndex);
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ----------------【3. 提交排盘按钮】----------------
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B261D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _submitAndNavigate,
                  child: const Text('确认排盘', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 单爻下拉选择控件
  Widget _buildYaoDropdownRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // 爻位名称
          SizedBox(
            width: 42,
            child: Text(
              _positionNames[index],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF8B261D)),
            ),
          ),
          const SizedBox(width: 12),
          // 下拉选择框
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<YaoType>(
                  value: _selectedYaos[index],
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF8B261D)),
                  items: const [
                    DropdownMenuItem(
                      value: YaoType.shaoYang,
                      child: Text('少阳 ━━━ (阳/静)', style: TextStyle(fontSize: 13, color: Colors.black87)),
                    ),
                    DropdownMenuItem(
                      value: YaoType.shaoYin,
                      child: Text('少阴 ━ ━ (阴/静)', style: TextStyle(fontSize: 13, color: Colors.black87)),
                    ),
                    DropdownMenuItem(
                      value: YaoType.laoYang,
                      child: Text('老阳 ━━━ ◯ (阳动变阴)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
                    ),
                    DropdownMenuItem(
                      value: YaoType.laoYin,
                      child: Text('老阴 ━ ━ ✕ (阴动变阳)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
                    ),
                  ],
                  onChanged: (YaoType? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedYaos[index] = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}