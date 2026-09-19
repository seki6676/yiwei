// lib/engine/liuyao_models.dart
import 'lunar_constants.dart';

/// 记录单爻的初始状态（摇卦结果）
/// 6: 老阴(阴动), 7: 少阳(阳静), 8: 少阴(阴静), 9: 老阳(阳动)
class YaoResult {
  final int value;
  YaoResult(this.value) : assert(value >= 6 && value <= 9);

  bool get isYang => value == 7 || value == 9;  // 本卦是否为阳
  bool get isDong => value == 6 || value == 9;  // 是否是动爻
  bool get bianIsYang => value == 9 ? false : (value == 6 ? true : isYang); // 变卦是否为阳
}

/// 完整的排盘结果实体类
class DivinationResult {
  final String dateStr;       // 占卜时间 (如: 2023-10-24 10:00)
  final String monthBranch;   // 月建地支
  final String dayStemBranch; // 日辰干支

  final String guaName;       // 本卦卦名
  final String bianGuaName;   // 变卦卦名

  final String palaceName;    // 所在八宫名称 (如: 乾宫)
  final WuXing palaceWuXing;  // 宫位五行

  final List<LineDetail> lines; // 6个爻的具体详情 (从下到上 0-5)

  DivinationResult({
    required this.dateStr,
    required this.monthBranch,
    required this.dayStemBranch,
    required this.guaName,
    required this.bianGuaName,
    required this.palaceName,
    required this.palaceWuXing,
    required this.lines,
  });
}

/// 每一爻详细的排盘数据
class LineDetail {
  final int index;          // 爻位 (0=初爻, 5=上爻)
  final bool isYang;        // 本卦阴阳
  final bool isDong;        // 是否动爻
  final bool bianIsYang;    // 变卦阴阳

  final bool isShi;         // 是否世爻
  final bool isYing;        // 是否应爻

  final String beast;       // 六兽 (青龙、朱雀...)

  final String stem;        // 本卦天干
  final String branch;      // 本卦地支
  final String liuQin;      // 本卦六亲

  final String bianStem;    // 变卦天干
  final String bianBranch;  // 变卦地支
  final String bianLiuQin;  // 变卦六亲

  final String? fuShen;     // 伏神 (如果有的话)

  LineDetail({
    required this.index,
    required this.isYang,
    required this.isDong,
    required this.bianIsYang,
    required this.isShi,
    required this.isYing,
    required this.beast,
    required this.stem,
    required this.branch,
    required this.liuQin,
    required this.bianStem,
    required this.bianBranch,
    required this.bianLiuQin,
    this.fuShen,
  });
}