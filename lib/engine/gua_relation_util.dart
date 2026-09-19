// lib/engine/gua_relation_util.dart

class GuaRelationUtil {
  /// 六合卦列表（共8个）
  /// 初爻与四爻合，二爻与五爻合，三爻与上爻合
  static const Set<String> _liuHeSet = {
    '天地否', '地天泰', '雷地豫', '地泽临',
    '山火贲', '水泽节', '泽水困', '火山旅'
  };

  /// 六冲卦列表（共10个）
  /// 初爻与四爻冲，二爻与五爻冲，三爻与上爻冲
  /// 包含：八纯卦 + 天雷无妄 + 雷天大壮
  static const Set<String> _liuChongSet = {
    '乾为天', '坎为水', '艮为山', '震为雷',
    '巽为风', '离为火', '坤为地', '兑为泽',
    '天雷无妄', '雷天大壮'
  };

  /// 判断本卦或变卦是否为六冲/六合卦
  /// 返回值为: "六合"、"六冲" 或空字符串 ""
  static String getChongHe(String fullName) {
    if (_liuHeSet.contains(fullName)) {
      return '六合';
    } else if (_liuChongSet.contains(fullName)) {
      return '六冲';
    }
    return ''; // 不是六合也不是六冲
  }

  /// 扩展：获取游魂/归魂属性（排盘时也经常需要直接显示）
  static const Set<String> _youHunSet = {
    '火地晋', '明夷', '天雷无妄', '风泽中孚', // 注意统一标准名称
    '山雷颐', '地风升', '水天需', '泽山咸' // 这里可根据您的 _guaNames 确保一致
  };

  static const Set<String> _guiHunSet = {
    '火天大有', '水地比', '山风蛊', '泽雷随',
    '风山渐', '天水讼', '地火明夷', '雷泽归妹'
  };
}