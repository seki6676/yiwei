import 'package:flutter/material.dart';
import 'meihua_result_page.dart';

/// 梅花易数手动指定起卦页（由初爻至上爻指定阴阳，并指定且仅指定一爻为动爻）
class MeiHuaManualPage extends StatefulWidget {
  const MeiHuaManualPage({super.key});

  @override
  State<MeiHuaManualPage> createState() => _MeiHuaManualPageState();
}

class _MeiHuaManualPageState extends State<MeiHuaManualPage> {

  final TextEditingController _subjectController = TextEditingController(text: '测近来运势');

  // 6 个爻的阴阳状态， true 为阳爻 ⚊，false 为阴爻 ⚋
  // index 0: 初爻, index 1: 二爻, ..., index 5: 上爻
  final List<bool> _isYangList = [true, true, true, true, true, true]; // 默认全阳（乾卦）

  // 当前指定的动爻位置（0-5 代表初爻至上爻），仅能且必须选择一个
  int _dongYaoIndex = 0; // 默认初爻动

  static const List<String> _baguaNames = ['坤', '震', '坎', '兑', '艮', '离', '巽', '乾'];

  /// 计算八卦名称（3个爻转八卦索引：阴=0, 阳=1）
  String _getGuaName(List<bool> yaos) {
    int code = (yaos[0] ? 1 : 0) + ((yaos[1] ? 1 : 0) << 1) + ((yaos[2] ? 1 : 0) << 2);
    return _baguaNames[code];
  }

  /// 获取卦的象义（如 乾为天、坤为地）
  String _getGuaXiang(String gua) {
    switch (gua) {
      case '乾': return '天';
      case '坤': return '地';
      case '坎': return '水';
      case '离': return '火';
      case '震': return '雷';
      case '艮': return '山';
      case '巽': return '风';
      case '兑': return '泽';
      default: return '';
    }
  }

  /// 计算本卦全名（如：天风姤、乾为天）
  String _calculateBenGua() {
    String lowerGua = _getGuaName(_isYangList.sublist(0, 3));
    String upperGua = _getGuaName(_isYangList.sublist(3, 6));

    if (lowerGua == upperGua) {
      return '$upperGua为${_getGuaXiang(upperGua)}';
    }
    return '${_getGuaXiang(upperGua)}${_getGuaXiang(lowerGua)}';
  }

  /// 计算变卦全名
  String _calculateBianGua() {
    List<bool> bianYaos = List.from(_isYangList);
    bianYaos[_dongYaoIndex] = !bianYaos[_dongYaoIndex]; // 动爻阴阳翻转

    String lowerGua = _getGuaName(bianYaos.sublist(0, 3));
    String upperGua = _getGuaName(bianYaos.sublist(3, 6));

    if (lowerGua == upperGua) {
      return '$upperGua为${_getGuaXiang(upperGua)}';
    }
    return '${_getGuaXiang(upperGua)}${_getGuaXiang(lowerGua)}';
  }

  /// 计算互卦全名（二三四爻为下互，三四五爻为上互）
  String _calculateHuGua() {
    List<bool> huLowerYaos = [_isYangList[1], _isYangList[2], _isYangList[3]];
    List<bool> huUpperYaos = [_isYangList[2], _isYangList[3], _isYangList[4]];

    String lowerGua = _getGuaName(huLowerYaos);
    String upperGua = _getGuaName(huUpperYaos);

    if (lowerGua == upperGua) {
      return '$upperGua为${_getGuaXiang(upperGua)}';
    }
    return '${_getGuaXiang(upperGua)}${_getGuaXiang(lowerGua)}';
  }

  @override
  Widget build(BuildContext context) {
    final positionNames = ['初爻', '二爻', '三爻', '四爻', '五爻', '上爻'];
    final benGua = _calculateBenGua();
    final huGua = _calculateHuGua();
    final bianGua = _calculateBianGua();

    return Scaffold(
      appBar: AppBar(
        title: const Text('梅花手动起卦'),
        backgroundColor: const Color(0xFF8B261D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部实时计算结果预览区
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              color: const Color(0xFF8B261D).withValues(alpha: 0.08),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem('本卦', benGua),
                      _buildSummaryItem('互卦', huGua),
                      _buildSummaryItem('变卦', bianGua),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '当前动爻：${positionNames[_dongYaoIndex]}动（第 ${_dongYaoIndex + 1} 爻）',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF8B261D)),
                  ),
                ],
              ),
            ),

            // 六爻选择列表（界面从上至下显示：上爻 → 初爻）
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final realIndex = 5 - index; // 5是上爻，0是初爻
                  final isYang = _isYangList[realIndex];
                  final isDong = (_dongYaoIndex == realIndex);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isDong ? const Color(0xFF8B261D) : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 48,
                            child: Text(
                              positionNames[realIndex],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDong ? const Color(0xFF8B261D) : Colors.black87,
                              ),
                            ),
                          ),
                          // 阴阳选项
                          Expanded(
                            child: Row(
                              children: [
                                _buildYaoTypeChip(realIndex, true, '阳 ⚊', isYang),
                                const SizedBox(width: 8),
                                _buildYaoTypeChip(realIndex, false, '阴 ⚋', !isYang),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // 动爻单选组件
                          InkWell(
                            onTap: () {
                              setState(() {
                                _dongYaoIndex = realIndex;
                              });
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: isDong ? const Color(0xFF8B261D) : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isDong ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                    size: 14,
                                    color: isDong ? Colors.white : Colors.black54,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '动爻',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isDong ? FontWeight.bold : FontWeight.normal,
                                      color: isDong ? Colors.white : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 底部确认排盘按钮
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B261D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // 获取用户输入的占测事项，若为空则设为默认值
                    final String subject = _subjectController.text.trim().isEmpty
                        ? '未填写事项'
                        : _subjectController.text.trim();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MeiHuaResultPage(
                          title: '手动指定 - $benGua',
                          querySubject:subject,
                          benGuaName: benGua,
                          huGuaName: huGua,
                          bianGuaName: bianGua,
                          dongYao: _dongYaoIndex + 1,
                        ),
                      ),
                    );
                  },
                  child: const Text('排 盘', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF8B261D))),
      ],
    );
  }

  Widget _buildYaoTypeChip(int yaoIndex, bool targetYang, String label, bool isSelected) {
    return Expanded(
      child: ChoiceChip(
        label: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
        selected: isSelected,
        selectedColor: const Color(0xFF2C3E50),
        backgroundColor: Colors.grey.shade100,
        showCheckmark: false,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _isYangList[yaoIndex] = targetYang;
            });
          }
        },
      ),
    );
  }
}