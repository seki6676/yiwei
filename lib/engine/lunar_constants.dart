// lib/engine/lunar_constants.dart

/// 五行
enum WuXing { metal, wood, water, fire, earth }

extension WuXingExt on WuXing {
  String get name {
    switch (this) {
      case WuXing.metal: return '金';
      case WuXing.wood: return '木';
      case WuXing.water: return '水';
      case WuXing.fire: return '火';
      case WuXing.earth: return '土';
    }
  }

  /// 计算与另一个五行的关系（用于定六亲）
  /// 返回值：0同我(兄弟), 1我生(子孙), 2我克(妻财), 3克我(官鬼), 4生我(父母)
  int getRelation(WuXing target) {
    if (this == target) return 0; // 同我
    if ((this == WuXing.water && target == WuXing.wood) ||
        (this == WuXing.wood && target == WuXing.fire) ||
        (this == WuXing.fire && target == WuXing.earth) ||
        (this == WuXing.earth && target == WuXing.metal) ||
        (this == WuXing.metal && target == WuXing.water)) return 1; // 我生
    if ((this == WuXing.water && target == WuXing.fire) ||
        (this == WuXing.fire && target == WuXing.metal) ||
        (this == WuXing.metal && target == WuXing.wood) ||
        (this == WuXing.wood && target == WuXing.earth) ||
        (this == WuXing.earth && target == WuXing.water)) return 2; // 我克
    if ((target == WuXing.water && this == WuXing.wood) ||
        (target == WuXing.wood && this == WuXing.fire) ||
        (target == WuXing.fire && this == WuXing.earth) ||
        (target == WuXing.earth && this == WuXing.metal) ||
        (target == WuXing.metal && this == WuXing.water)) return 4; // 生我
    return 3; // 克我
  }
}

/// 十天干
const List<String> TIAN_GAN = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];

/// 十二地支
const List<String> DI_ZHI = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];

/// 地支对应的五行
final Map<String, WuXing> DI_ZHI_WUXING = {
  '子': WuXing.water, '亥': WuXing.water,
  '寅': WuXing.wood, '卯': WuXing.wood,
  '巳': WuXing.fire, '午': WuXing.fire,
  '申': WuXing.metal, '酉': WuXing.metal,
  '辰': WuXing.earth, '戌': WuXing.earth, '丑': WuXing.earth, '未': WuXing.earth,
};

/// 六亲
const List<String> LIU_QIN = ['兄弟', '子孙', '妻财', '官鬼', '父母'];

/// 六兽 (六神)
const List<String> SIX_BEASTS = ['青龙', '朱雀', '勾陈', '腾蛇', '白虎', '玄武'];

/// 八卦基础定义 (乾、兑、离、震、巽、坎、艮、坤)
const List<String> BA_GUA = ['乾', '兑', '离', '震', '巽', '坎', '艮', '坤'];

/// 八宫五行属性
final Map<String, WuXing> BA_GUA_WUXING = {
  '乾': WuXing.metal, '兑': WuXing.metal,
  '离': WuXing.fire,
  '震': WuXing.wood, '巽': WuXing.wood,
  '坎': WuXing.water,
  '艮': WuXing.earth, '坤': WuXing.earth,
};