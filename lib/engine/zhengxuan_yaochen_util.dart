// lib/engine/zhengxuan_yaochen_util.dart

class ZhengXuanYaoChenUtil {
  /// 常规：乾卦爻辰（适用于所有普通阳爻）
  /// 从初爻到上爻
  static const List<String> _qianYaoChen = ['子', '寅', '辰', '午', '申', '戌'];

  /// 常规：坤卦爻辰（适用于所有普通阴爻）
  /// 从初爻到上爻
  static const List<String> _kunYaoChen = ['未', '酉', '亥', '丑', '卯', '巳'];

  /// 特例：泰卦爻辰（建寅起连排）
  static const List<String> _taiYaoChen = ['寅', '卯', '辰', '巳', '午', '未'];

  /// 特例：否卦爻辰（建申起连排）
  static const List<String> _piYaoChen = ['申', '酉', '戌', '亥', '子', '丑'];

  /// 获取郑玄十二爻辰
  /// [guaName] 卦名，例如 "地天泰"、"天地否" 或是简称 "泰"、"否"
  /// [yaoList] 长度为6的布尔数组，代表初爻到上爻。true代表阳爻，false代表阴爻。
  static List<String> getYaoChen(String guaName, List<bool> yaoList) {
    // 1. 特例拦截：泰卦
    if (guaName.contains('泰')) {
      return List.from(_taiYaoChen); // 返回特例数组
    }

    // 2. 特例拦截：否卦
    if (guaName.contains('否')) {
      return List.from(_piYaoChen); // 返回特例数组
    }

    // 3. 常规排布：阳爻就乾位，阴爻就坤位
    List<String> result = [];
    for (int i = 0; i < 6; i++) {
      if (yaoList[i]) {
        // 阳爻，取乾卦同位地支
        result.add(_qianYaoChen[i]);
      } else {
        // 阴爻，取坤卦同位地支
        result.add(_kunYaoChen[i]);
      }
    }

    return result;
  }
}