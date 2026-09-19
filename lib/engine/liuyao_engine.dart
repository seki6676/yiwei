// lib/engine/liuyao_engine.dart
import 'lunar_constants.dart';
import 'liuyao_models.dart';

class LiuYaoEngine {

  /// 获取三爻组成的八卦二进制值 (阳为1, 阴为0)
  /// 从下往上分别是 bot, mid, top
  static int _getTrigramValue(bool bot, bool mid, bool top) {
    int val = 0;
    if (top) val |= 4; // 100
    if (mid) val |= 2; // 010
    if (bot) val |= 1; // 001
    return val;
  }

  /// 将 3位二进制 转换为 八卦名称
  static String _getBaguaName(int val) {
    switch (val) {
      case 7: return '乾'; // 111
      case 3: return '兑'; // 011
      case 5: return '离'; // 101
      case 1: return '震'; // 001
      case 6: return '巽'; // 110
      case 2: return '坎'; // 010
      case 4: return '艮'; // 100
      case 0: return '坤'; // 000
      default: throw Exception('非法的八卦值');
    }
  }

  /// 将 3位二进制 转换为 自然物象（用于组合卦名，如 天风姤）
  static String _getNatureName(int val) {
    switch (val) {
      case 7: return '天';
      case 3: return '泽';
      case 5: return '火';
      case 1: return '雷';
      case 6: return '风';
      case 2: return '水';
      case 4: return '山';
      case 0: return '地';
      default: return '';
    }
  }

  /// 核心算法：【寻世认宫诀】
  /// 利用上下卦的二进制异或(XOR)值，完美推导世爻位置和所属宫位！
  /// 返回值：[世爻索引(0-5), 宫位八卦二进制值]
  static List<int> _getShiAndPalace(int lowerVal, int upperVal) {
    int xor = lowerVal ^ upperVal; // 上下卦进行异或

    int shiIndex;
    int palaceVal;

    switch (xor) {
      case 0: // 000 -> 八纯卦 (上下相同)，世在六(索引5)，宫位为上卦
        shiIndex = 5;
        palaceVal = upperVal;
        break;
      case 1: // 001 -> 一世卦，世在初(0)，宫位为上卦
        shiIndex = 0;
        palaceVal = upperVal;
        break;
      case 3: // 011 -> 二世卦，世在二(1)，宫位为上卦
        shiIndex = 1;
        palaceVal = upperVal;
        break;
      case 7: // 111 -> 三世卦，世在三(2)，宫位为上卦
        shiIndex = 2;
        palaceVal = upperVal;
        break;
      case 6: // 110 -> 四世卦，世在四(3)，宫位为【下卦取反】
        shiIndex = 3;
        palaceVal = (~lowerVal) & 7; // 取反并保留后3位
        break;
      case 4: // 100 -> 五世卦，世在五(4)，宫位为【下卦取反】
        shiIndex = 4;
        palaceVal = (~lowerVal) & 7;
        break;
      case 5: // 101 -> 游魂卦，世在四(3)，宫位为【下卦取反】
        shiIndex = 3;
        palaceVal = (~lowerVal) & 7;
        break;
      case 2: // 010 -> 归魂卦，世在三(2)，宫位为【下卦】
        shiIndex = 2;
        palaceVal = lowerVal;
        break;
      default:
        throw Exception('算卦异常');
    }
    return [shiIndex, palaceVal];
  }

  /// 核心算法：【纳甲法】给对应的爻装配天干和地支
  /// baguaVal: 八卦的二进制值
  /// isUpper: 是否是外卦(上卦)
  /// indexInTrigram: 在单卦中的位置 (0:初/四爻, 1:二/五爻, 2:三/上爻)
  static Map<String, String> _getNaJia(int baguaVal, bool isUpper, int indexInTrigram) {
    String stem = '';
    String branch = '';

    // 纳地支口诀推导
    switch (baguaVal) {
      case 7: // 乾：内子寅辰，外午申戌
        stem = isUpper ? '壬' : '甲';
        branch = isUpper ? ['午', '申', '戌'][indexInTrigram] : ['子', '寅', '辰'][indexInTrigram];
        break;
      case 0: // 坤：内未巳卯，外丑亥酉
        stem = isUpper ? '癸' : '乙';
        branch = isUpper ? ['丑', '亥', '酉'][indexInTrigram] : ['未', '巳', '卯'][indexInTrigram];
        break;
      case 1: // 震：内子寅辰，外午申戌 (同乾)
        stem = '庚';
        branch = isUpper ? ['午', '申', '戌'][indexInTrigram] : ['子', '寅', '辰'][indexInTrigram];
        break;
      case 6: // 巽：内丑亥酉，外未巳卯
        stem = '辛';
        branch = isUpper ? ['未', '巳', '卯'][indexInTrigram] : ['丑', '亥', '酉'][indexInTrigram];
        break;
      case 2: // 坎：内寅辰午，外申戌子
        stem = '戊';
        branch = isUpper ? ['申', '戌', '子'][indexInTrigram] : ['寅', '辰', '午'][indexInTrigram];
        break;
      case 5: // 离：内卯丑亥，外酉未巳
        stem = '己';
        branch = isUpper ? ['酉', '未', '巳'][indexInTrigram] : ['卯', '丑', '亥'][indexInTrigram];
        break;
      case 4: // 艮：内辰午申，外戌子寅
        stem = '丙';
        branch = isUpper ? ['戌', '子', '寅'][indexInTrigram] : ['辰', '午', '申'][indexInTrigram];
        break;
      case 3: // 兑：内巳卯丑，外亥酉未
        stem = '丁';
        branch = isUpper ? ['亥', '酉', '未'][indexInTrigram] : ['巳', '卯', '丑'][indexInTrigram];
        break;
    }
    return {'stem': stem, 'branch': branch};
  }

  /// 64卦卦名速查字典（自然组合拼接）
  static final Map<String, String> _guaNames = {
    '天天': '乾为天', '天风': '天风姤', '天山': '天山遁', '天地': '天地否',
    '风地': '风地观', '山地': '山地剥', '火地': '火地晋', '火天': '火天大有',
    '坎水': '坎为水', '水泽': '水泽节', '水雷': '水雷屯', '水火': '水火既济',
    '泽火': '泽火革', '雷火': '雷火丰', '地火': '地火明夷', '地水': '地水师',
    '艮山': '艮为山', '山火': '山火贲', '山天': '山天大畜', '山泽': '山泽损',
    '火泽': '火泽睽', '天泽': '天泽履', '风泽': '风泽中孚', '风山': '风山渐',
    '震雷': '震为雷', '雷地': '雷地豫', '雷水': '雷水解', '雷风': '雷风恒',
    '地风': '地风升', '水风': '水风井', '泽风': '泽风大过', '泽雷': '泽雷随',
    '巽风': '巽为风', '风天': '风天小畜', '风火': '风火家人', '风雷': '风雷益',
    '天雷': '天雷无妄', '火雷': '火雷噬嗑', '山雷': '山雷颐', '山风': '山风蛊',
    '离火': '离为火', '火山': '火山旅', '火风': '火风鼎', '火水': '火水未济',
    '山水': '山水蒙', '风水': '风水涣', '天水': '天水讼', '天火': '天火同人',
    '坤地': '坤为地', '地雷': '地雷复', '地泽': '地泽临', '地天': '地天泰',
    '雷天': '雷天大壮', '泽天': '泽天夬', '水天': '水天需', '水地': '水地比',
    '兑泽': '兑为泽', '泽水': '泽水困', '泽地': '泽地萃', '泽山': '泽山咸',
    '水山': '水山蹇', '地山': '地山谦', '雷山': '雷山小过', '雷泽': '雷妹归妹', // 修正别字：雷泽归妹
  };

  /// 通过自然组合获取标准卦名 (如 传入 上天, 下风，返回 天风姤)
  static String _getFullGuaName(String upperNat, String lowerNat) {
    if (upperNat == lowerNat) {
      // 纯卦映射
      Map<String, String> pureMap = {'天': '天天', '水': '坎水', '山': '艮山', '雷': '震雷', '风': '巽风', '火': '离火', '地': '坤地', '泽': '兑泽'};
      return _guaNames[pureMap[upperNat]] ?? '$upperNat$lowerNat';
    }
    return _guaNames['$upperNat$lowerNat'] ?? '$upperNat$lowerNat';
  }
}