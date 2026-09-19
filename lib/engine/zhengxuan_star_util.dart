// lib/engine/zhengxuan_star_util.dart

class ZhengXuanStarUtil {
  /// 郑玄十二辰值宿映射表
  /// 将地支（爻辰）映射到对应的二十八星宿
  static const Map<String, String> _chenToStars = {
    '子': '女、虚、危',
    '丑': '斗、牛',
    '寅': '尾、箕',
    '卯': '氐、房、心',
    '辰': '角、亢',
    '巳': '翼、轸',
    '午': '柳、星、张',
    '未': '井、鬼',
    '申': '觜、参',
    '酉': '胃、昴、毕',
    '戌': '奎、娄',
    '亥': '室、壁',
  };

  /// 根据排出的爻辰列表，获取对应的星宿列表
  /// [yaoChenList] 是从初爻到上爻的爻辰数组，如 ['未', '寅', '亥', '丑', '申', '巳']
  static List<String> getStarsFromYaoChen(List<String> yaoChenList) {
    return yaoChenList.map((chen) {
      return _chenToStars[chen] ?? '';
    }).toList();
  }
}