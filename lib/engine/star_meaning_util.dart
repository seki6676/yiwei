// lib/engine/star_meaning_util.dart

/// 二十八星宿象意实体类
class StarMeaning {
  final String name;        // 星宿名 (如: 角)
  final String planet;      // 七曜 (如: 木曜)
  final String animal;      // 禽类 (如: 蛟禽)
  final String coreMeaning; // 核心象意 (如: 类主交易)
  final String detail;      // 详细解释

  const StarMeaning({
    required this.name,
    required this.planet,
    required this.animal,
    required this.coreMeaning,
    required this.detail,
  });
}

class StarMeaningUtil {
  /// 二十八星宿完整象意字典
  static const Map<String, StarMeaning> _meanings = {
    '角': StarMeaning(name: '角', planet: '木曜', animal: '蛟禽', coreMeaning: '类主交易',
        detail: '角为天门，三光之路，十二度。七曜与天皆始于角，居二十八宿之首，类主领袖。角宿二星象青龙两角，搏杀之用，主凶丧斗狠，类主将兵。黄道过角宿两星，称天关、天门或天罗，类主刑狱、大风、砂石、疾病。'),
    '亢': StarMeaning(name: '亢', planet: '金曜', animal: '龙禽', coreMeaning: '类主求谋',
        detail: '亢宿为天庭，尚书之曹，十度。四星居苍龙之颈，犹咽喉，主宗庙，名天府、天庭或天门。天子内朝，总摄天下奏事，象听讼、理狱、录功。亢为疏庙，主奏事，明目达聪，天子外朝听证之所。'),
    '氐': StarMeaning(name: '氐', planet: '土曜', animal: '貉禽', coreMeaning: '类主财帛',
        detail: '氐为宿宫，路寝所止，十七度。四星居苍龙之胸，龙胸主要害，亦象前足。氐者，日月五星之门户，为后妃之府，主阴私、徭役、疫病。'),
    '房': StarMeaning(name: '房', planet: '日曜', animal: '兔禽', coreMeaning: '类主文书',
        detail: '房宿为明堂，政教之道，五度，四星居苍龙之腹，为天子后寝，御群阴之处，明堂布政之宫。明堂者，君王之位，四表之道，而日月五星之所出入也。房曰天驷，又曰天马，主车驾。别为天府，主开闭，为蓄藏之所。'),
    '心': StarMeaning(name: '心', planet: '月曜', animal: '狐禽', coreMeaning: '类主风水',
        detail: '心为天王之位，六度。三星居苍龙之腰，肾脏之所，主新陈代谢。心宿三星，象三足鼎立，又名大火、商星。中星曰明堂，天子正位，象衙门、府第、席位。前星主太子，后星主庶子。积卒十二星，象军营，主刀兵。'),
    '尾': StarMeaning(name: '尾', planet: '火曜', animal: '虎禽', coreMeaning: '类主六畜',
        detail: '九星居苍龙之尾，龙摆尾而行，主速动。又名九江，十八度。龟五星，职掌吉凶及赏罚，为官职之类神。天江四星，在尾之北，主太阴，象关梁。'),
    '箕': StarMeaning(name: '箕', planet: '水曜', animal: '豹禽', coreMeaning: '类主前程',
        detail: '居苍龙之尾，龙尾动，旋风至，九度。箕曰天口、女相，主口舌、谗言。箕主风，类八风，象风波。杵三星，杵米之俱，司米粮事。糠一星，吉则丰，凶则饥，主米粮事。曰狐星，主狐貉。曰天鸡，主时。曰天阵，主金。'),
    '斗': StarMeaning(name: '斗', planet: '木曜', animal: '獬禽', coreMeaning: '类主身命',
        detail: '斗为主爵禄，褒贤进士，二十四度。六星为天子宿，执掌官职爵禄，参议政事，又主兵斗。鳖十四星，可水可陆，类主桥梁。南二星为天库，主仓储、库房。天鸡二星，主信息、报时、节候。'),
    '牛': StarMeaning(name: '牛', planet: '金曜', animal: '牛禽', coreMeaning: '类主耕种',
        detail: '牛为主桥梁，七政之始，六度。六星古称牵牛，阳气所起，状如牛角，主桥梁、牺牲、神庙、祭祀。织女三星，天女也，主嫁娶、珍果、丝绵、宝玉。旗端四星，为主标志，定时之星。东足四星，主漏刻、律吕。'),
    '女': StarMeaning(name: '女', planet: '土曜', animal: '蝠禽', coreMeaning: '类主婚姻',
        detail: '女为主布帛，天之内藏，十十度。四星组合，状如箕，字如女，又名须女、婺女，须谓贱妾。女四星象天之少府，主布帛、裁制、嫁娶。'),
    '虚': StarMeaning(name: '虚', planet: '日曜', animal: '鼠禽', coreMeaning: '类主盗贼',
        detail: '虚宿为庙堂，主祭祀事，九度。虚为冢宰之官，平理天下，覆藏万物，昼伏夜出。二星位居北官中央，曰玄枵，耗也；曰颛顼，虚也。虚宿主邑居、庙堂、祭祀、淫逸、责罚、死丧、哭泣、虚耗、败坏。'),
    '危': StarMeaning(name: '危', planet: '月曜', animal: '燕禽', coreMeaning: '类主刑克',
        detail: '危为坟墓，以识先祖，十六度。危之言，高且险，三星居龟蛇之尾，状如尖屋顶。曰天市宫，类天子之庙堂，象百姓之市井，主邑居、庙堂、架屋、收藏、风雨、墓坟、祠祀、死丧、哭泣。'),
    '室': StarMeaning(name: '室', planet: '火曜', animal: '猪禽', coreMeaning: '类主家宅',
        detail: '营室二星，为主军粮，以禀士卒，十九度。群星状如房屋，是谓营室，以之定正，天下作宫室以营室为中正。营室主水，昏正而裁，是谓玄宫。'),
    '壁': StarMeaning(name: '壁', planet: '水曜', animal: '獝禽', coreMeaning: '类主渔事',
        detail: '东壁类主翰墨，九度。二星居室宿之外，形如围墙，又名东壁，为天下文章、图书之秘府。类主文章、道术、土功、田宅。霹雳南四星，主雷雨。天厩十星，盖天马之厩，主道路。五星，象刈具，主收获。'),
    '奎': StarMeaning(name: '奎', planet: '木曜', animal: '狼禽', coreMeaning: '类主捕捉',
        detail: '五兵之库，禁御暴乱，十八度。奎宿腰细头尖，形似破鞋，十六星绕鞋而生，形象鞋履，类天之武库，主文章。奎南七星，曰外屏，蔽之天溷，类主屏障、包围、围墙、罗网。天溷七星，象天之厕，主污秽、垃圾。'),
    '娄': StarMeaning(name: '娄', planet: '金曜', animal: '狗禽', coreMeaning: '类主门户',
        detail: '娄为苑牧，主给享祠，十三度。娄三星为天狱，类主礼乐、牧苑、牺牲、供给、郊祀、兴兵、聚众。左更五星，象山野，主仁智。右更五星，象牧师，类主豢养、放牧、礼义。天仓六星，象粮仓，主储藏。'),
    '胃': StarMeaning(name: '胃', planet: '土曜', animal: '雉禽', coreMeaning: '类主手艺',
        detail: '胃为仓廪，五谷所聚，十六度。三星象人之胃，类象天仓，五谷之府，主积聚、讨捕、诛杀、殂醢。天廪四星，主粮仓。天仓十三星，同天廪，俱为五谷之府。大陵八星，主陵墓、墓碑、死丧。'),
    '昴': StarMeaning(name: '昴', planet: '日曜', animal: '鸡禽', coreMeaning: '类主音信',
        detail: '昴为主狱事，典治决断，十一度。七星居虎中，有簇聚、团属之意。昴象天之耳目，司考察，主狱事、奏对、兵戈、刑杀。卷舌六星，主口舌、妄语、谗言。天谗一星，主医巫。砺石四星，磨砺锋刃，主刀兵、凶杀。'),
    '毕': StarMeaning(name: '毕', planet: '月曜', animal: '乌禽', coreMeaning: '类主疾病',
        detail: '毕为主边兵，防备夷狄，十度。八星状如叉爪，主伺鬼方之动静，察奸谋，备外患，立附耳以稽不祥。毕主阴雨，天之雨师，月过毕宿，雨季来临。'),
    '觜': StarMeaning(name: '觜', planet: '火曜', animal: '猴禽', coreMeaning: '类主谒见',
        detail: '觜为主保藏，收敛秋物，一度。三星居虎口，主天阙，物皆收藏。曰刀钺，主斩刈。曰天货，主葆旅。形如鼎足，主行旅、动移、流放、驱逐、往来。'),
    '参': StarMeaning(name: '参', planet: '水曜', animal: '猿禽', coreMeaning: '类主买卖',
        detail: '参为天将，主斩刈收获，十度。七星主白虎之体，主权衡、驿馆、将兵、军营。一曰斧钺，主斩杀。一曰天狱，主刑罚。天厕四星，天屎一星，主疾病。'),
    '井': StarMeaning(name: '井', planet: '木曜', animal: '犴禽', coreMeaning: '类主词讼',
        detail: '东井八星，为主水衡，以法平时，三十一度。类主水泉、酒食、女主、诸侯、帝戚、三公。钺一星，附井之前，主奢淫。月宿井，主风雨。'),
    '鬼': StarMeaning(name: '鬼', planet: '金曜', animal: '羊禽', coreMeaning: '类主走失',
        detail: '舆鬼为视明，主察奸谋，二度。四星方形，似木柜，中央白，积尸气，主疾病、死亡、诛斩、祭祀、社祠、监察。曰舆鬼，舆乃车，车形方，鬼亦方。'),
    '柳': StarMeaning(name: '柳', planet: '土曜', animal: '獐禽', coreMeaning: '类主添丁',
        detail: '柳为上食，主和滋味，十三度。八星象朱鸟之喙，主御膳、囿食、酒肆、仓库。时至于夏，云行雨施，品物流行，主雷雨、草木。'),
    '星': StarMeaning(name: '星', planet: '日曜', animal: '马禽', coreMeaning: '类主出行',
        detail: '星宿为衣裳，覆盖身体，七度。七星象朱雀之颈，物之在喉，终不久留，类主急事。轩辕十七星凡十四变，盛为雷，激为电，和为雨，怒为风，乱为雾，凝为霜，散为露，聚为气，立为虹霓，离为背谲，分为抱珥。'),
    '张': StarMeaning(name: '张', planet: '月曜', animal: '鹿禽', coreMeaning: '类主开张',
        detail: '张为主宾客，赐与燕嬉，十八度。六星之形似鸟翼张开，欲飞翔，象引弓，类主天府、饮食、品尝、鉴赏，长养万物。南方老人星，主寿。'),
    '翼': StarMeaning(name: '翼', planet: '火曜', animal: '蛇禽', coreMeaning: '类主行人',
        detail: '翼为天唱，天子乐府，主远客，二十度。二十二星似张弓，鸟翼蛇行。乐乃阳盛，系于巳，大合于夏。和五音，调六律，协八佾，御天宫。'),
    '轸': StarMeaning(name: '轸', planet: '水曜', animal: '蚓禽', coreMeaning: '类主引进',
        detail: '轸为死丧，以知凶荒，十八度，象朱雀之尾，主文章。曰天车，主车骑、任载、盗贼、征伐、丧车。四星为天府冢宰，察殃咎，知凶灾，主稽察。'),
  };

  /// 通过星宿名（如 "角" 或 "戌角"）查询详细象意
  static StarMeaning? getMeaning(String starName) {
    if (starName.isEmpty) return null;

    // 如果传入的是带地支的名字（如“戌角”），截取最后一个字
    String coreName = starName.length > 1 ? starName.substring(1) : starName;
    return _meanings[coreName];
  }
}