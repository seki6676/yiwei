// lib/engine/jingfang_sixteen_vars.dart

class JingFangSixteenVars {
  /// 十六变序性质列表（按照 0-16 变序排列）
  static const List<String> variations = [
    '上世', '一世', '二世', '三世', '四世', '五世', '游魂', '外戒',
    '内戒', '归魂', '绝命', '血脉', '肌肉', '骸骨', '棺椁', '冢墓', '本体'
  ];

  /// 八宫十六变顺序表（完全对齐您提供的图表）
  static const Map<String, List<String>> _palaceSequences = {
    '乾宫': ['乾', '姤', '遁', '否', '观', '剥', '晋', '旅', '鼎', '大有', '离', '噬嗑', '颐', '益', '无妄', '同人', '乾'],
    '坎宫': ['坎', '节', '屯', '既济', '革', '丰', '明夷', '复', '临', '师', '坤', '谦', '小过', '咸', '蹇', '比', '坎'],
    '艮宫': ['艮', '贲', '大畜', '损', '睽', '履', '中孚', '小畜', '家人', '渐', '巽', '涣', '讼', '未济', '蒙', '蛊', '艮'],
    '震宫': ['震', '豫', '解', '恒', '升', '井', '大过', '困', '萃', '随', '兑', '夬', '需', '泰', '大壮', '归妹', '震'],
    '巽宫': ['巽', '小畜', '家人', '益', '无妄', '噬嗑', '颐', '贲', '大畜', '蛊', '艮', '剥', '晋', '否', '观', '渐', '巽'],
    '离宫': ['离', '旅', '鼎', '未济', '蒙', '涣', '讼', '姤', '遁', '同人', '乾', '履', '中孚', '损', '睽', '大有', '离'],
    '坤宫': ['坤', '复', '临', '泰', '大壮', '夬', '需', '节', '屯', '比', '坎', '井', '大过', '恒', '升', '师', '坤'],
    '兑宫': ['兑', '困', '萃', '咸', '蹇', '谦', '小过', '豫', '解', '归妹', '震', '丰', '明夷', '既济', '革', '随', '兑'],
  };

  static Map<String, List<String>>? _reverseLookup;

  /// 根据卦的简称（如 "姤"、"既济"）查询其在十六变中的所有宫位和性质
  /// 返回示例：["乾宫一世", "离宫外戒"]
  static List<String> getProperties(String guaName) {
    if (_reverseLookup == null) {
      _buildReverseLookupMap();
    }

    // 如果传入的是全称 (如"天风姤")，自动提取出简称用于查询
    String shortName = _extractShortName(guaName);
    return _reverseLookup![shortName] ?? [];
  }

  /// 构建反向查询字典 (按需懒加载，O(1)复杂度查询)
  static void _buildReverseLookupMap() {
    _reverseLookup = {};
    _palaceSequences.forEach((palace, sequence) {
      for (int i = 0; i < sequence.length - 1; i++) { // -1是为了过滤掉第16变'本体'(与上世重复)
        String hexagram = sequence[i];
        String property = variations[i];

        if (!_reverseLookup!.containsKey(hexagram)) {
          _reverseLookup![hexagram] = [];
        }
        _reverseLookup![hexagram]!.add('$palace$property');
      }
    });
  }

  /// 辅助方法：将 64 卦全称转换为短名以匹配图表
  static String _extractShortName(String fullName) {
    // 针对双字简称做特殊处理 (如 既济、未济、噬嗑 等)
    const doubleChars = ['既济', '未济', '小畜', '大畜', '小过', '大过', '无妄', '噬嗑', '同人', '家人', '明夷', '归妹', '中孚'];
    for (String dc in doubleChars) {
      if (fullName.contains(dc)) return dc;
    }
    // 普通单字卦直接取最后一个字 (如 "天风姤" -> "姤")
    return fullName.substring(fullName.length - 1);
  }
}