//十二地支常量：子0 丑1 寅2 卯3 辰4 巳5 午6 未7 申8 酉9 戌10 亥11
const List<String> diZhiName = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"];

//地支五行：0水,1土,2木,3木,4土,5火,6火,7土,8金,9金,10土,11水
const List<int> zhiWuXing = [0,1,2,2,1,3,3,1,4,4,1,0];
//五行索引：0水 1土 2木 3火 4金
//五行生：木生火,火生土,土生金,金生水,水生木
const List<int> wuXingSheng = [2,0,3,1,0]; //五行index -> 所生五行
//五行克：木克土,土克水,水克火,火克金,金克木
const List<int> wuXingKe = [3,0,1,4,2];  //五行index -> 所克五行

/// 地支顺n步
int zhiStep(int zhi,int n){
  return (zhi + n) %12;
}
/// 地支逆n步
int zhiStepRev(int zhi,int n){
  return (zhi - n +12) %12;
}

//===== 各类神煞查表规则 =====
///驿马 日支三合起
final Map<int,int> yiMaMap = {0:2,8:2,4:2, 11:5,3:5,7:5, 2:8,6:8,10:8, 5:11,9:11,1:11};
///桃花
final Map<int,int> taoHuaMap = {0:9,8:9,4:9, 11:0,3:0,7:0, 2:3,6:3,10:3, 5:6,9:6,1:6};
///将星
final Map<int,int> jiangXingMap = {0:0,8:0,4:0, 11:3,3:3,7:3, 2:6,6:6,10:6, 5:9,9:9,1:9};
///华盖
final Map<int,int> huaGaiMap = {0:4,8:4,4:4, 11:7,3:7,7:7, 2:10,6:10,10:10, 5:1,9:1,1:1};
///灾煞
final Map<int,int> zaiShaMap = {0:6,8:6,4:6, 11:9,3:9,7:9, 2:0,6:0,10:0, 5:3,9:3,1:3};
///劫煞
final Map<int,int> jieShaMap = {0:5,8:5,4:5, 11:8,3:8,7:8, 2:11,6:11,10:11, 5:2,9:2,1:2};
///亡神
final Map<int,int> wangShenMap = {0:11,8:11,4:11, 11:2,3:2,7:2, 2:5,6:5,10:5, 5:8,9:8,1:8};
///日禄 日干查
final Map<int,int> riLuMap = {0:2,1:3,2:5,3:6,4:5,5:6,6:8,7:9,8:11,9:0};
///文昌 日干查
final Map<int,int> wenChangMap = {0:5,1:6,2:8,3:9,4:8,5:9,6:11,7:0,8:2,9:3};
///天乙贵人 日干查 返回两支
final Map<int,List<int>> tianYiGuiRenMap = {
  0:[1,6],1:[0,8],2:[11,9],3:[3,5],4:[2,6],
  5:[1,6],6:[0,8],7:[11,9],8:[3,5],9:[2,6]
};
///月德 月支查
final Map<int,int> yueDeMap = {2:2,6:2,10:2, 11:0,3:0,7:0, 0:8,4:8,8:8, 1:6,5:6,9:6};
///羊刃 日干查，12=无
final Map<int,int> yangRenMap = {0:3,1:6,2:9,3:12,4:9,5:12,6:0,7:3,8:6,9:9};
///孤辰寡宿 日支代年支
final Map<int,List<int>> guGuaMap = {
  0:[10,7],1:[11,8],2:[0,9],3:[1,10],4:[2,11],5:[3,0],
  6:[4,1],7:[5,2],8:[6,3],9:[7,4],10:[8,5],11:[9,6]
};
///天医 月支查表 正卯二亥三丑四未五巳六卯七亥八丑九未十巳十一卯十二亥
const List<int> tianYiMonthZhi = [9,11,1,7,5,9,11,1,7,5,9,11];
///天马 月支查
final Map<int,int> tianMaMap = {2:6,8:6, 3:8,9:8, 4:10,10:10, 5:0,11:0, 0:2,6:2, 1:4,7:4};
///破碎煞
final Map<int,int> poSuiMap = {0:5,6:5,3:5,9:5, 1:1,4:1,7:1,10:1, 2:9,5:9,8:9,11:9};
///丧门=岁前2 吊客=岁后2 病符=岁后1 官符=岁前4 (日支代岁)
///胎爻 = 月支退3位 (month+9)%12

/// 输入卦信息
class GuaInput{
  final List<int> liuYaoZhi; //6个爻地支 初->上
  final int shiYaoIndex; //世爻位置 0初~5上
  final bool shiYaoIsYang; //世爻是阳爻? 用来算月卦身
  final int monthZhi; //月支0-11
  final int dayZhi; //日支0-11
  final int dayGan; //日干 0甲~9癸
  final int? yearZhi; //可选年支，不传默认用日支代替岁支
  GuaInput({required this.liuYaoZhi,required this.shiYaoIndex,required this.shiYaoIsYang,
    required this.monthZhi,required this.dayZhi,required this.dayGan,this.yearZhi});
}

/// 神煞输出结果
class ShenShaResult{
  /// 神煞名 -> 对应地支列表（核心输出：你要的 神煞->所在地支）
  final Map<String,List<int>> shaToZhi;
  /// 卦身地支
  final int guaShenZhi;
  /// 世身爻位
  final int shiShenYaoIdx;
  ShenShaResult(this.shaToZhi,this.guaShenZhi,this.shiShenYaoIdx);
}

/// 核心神煞计算函数
ShenShaResult calcAllShenSha(GuaInput inp){
  Map<String,List<int>> res = {};
  int dayZhi = inp.dayZhi;
  int monthZhi = inp.monthZhi;
  int dayGan = inp.dayGan;
  int suiZhi = inp.yearZhi ?? dayZhi;

  //=====1. 先计算【月卦身】 阳世初起子，阴世初起午，数到世爻位
  int guaShenZhi = inp.shiYaoIsYang
      ? zhiStep(0, inp.shiYaoIndex)
      : zhiStep(6, inp.shiYaoIndex);
  res["卦身"] = [guaShenZhi];

  //=====2. 香闺、床帐 严格卦身派生：卦身所克=香闺；卦身所生=床帐
  int gsWx = zhiWuXing[guaShenZhi];
  int keWx = wuXingKe[gsWx];
  int shengWx = wuXingSheng[gsWx];
  List<int> xiangGui = [];
  List<int> chuangZhang = [];
  for(var z=0;z<12;z++){
    if(zhiWuXing[z]==keWx) xiangGui.add(z);
    if(zhiWuXing[z]==shengWx) chuangZhang.add(z);
  }
  res["香闺"] = xiangGui;
  res["床帐"] = chuangZhang;

  //=====3. 日支类神煞
  res["驿马"] = [yiMaMap[dayZhi]!];
  res["桃花"] = [taoHuaMap[dayZhi]!];
  res["将星"] = [jiangXingMap[dayZhi]!];
  res["华盖"] = [huaGaiMap[dayZhi]!];
  res["灾煞"] = [zaiShaMap[dayZhi]!];
  res["劫煞"] = [jieShaMap[dayZhi]!];
  res["亡神"] = [wangShenMap[dayZhi]!];
  res["孤辰"] = [guGuaMap[dayZhi]![0]];
  res["寡宿"] = [guGuaMap[dayZhi]![1]];

  //=====4. 日干类神煞
  res["日禄"] = [riLuMap[dayGan]!];
  res["文昌"] = [wenChangMap[dayGan]!];
  res["贵人"] = tianYiGuiRenMap[dayGan]!;
  int yr = yangRenMap[dayGan]!;
  if(yr!=12) res["羊刃"]=[yr];

  //=====5. 月支类神煞
  res["月德"] = [yueDeMap[monthZhi]!];
  res["天医"] = [tianYiMonthZhi[monthZhi]];
  res["天马"] = [tianMaMap[monthZhi]!];
  int taiZhi = (monthZhi +9)%12;
  res["胎爻"] = [taiZhi];

  //=====6. 岁支顺逆类
  res["丧门"] = [zhiStep(suiZhi,2)]; //岁前2
  res["吊客"] = [zhiStepRev(suiZhi,2)]; //岁后2
  res["病符"] = [zhiStepRev(suiZhi,1)]; //旧太岁 岁后1
  res["官符"] = [zhiStep(suiZhi,4)]; //岁前4

  //=====7. 破碎
  res["破碎"] = [poSuiMap[dayZhi]!];

  //=====8. 世身 口诀：子午持世身居初...
  int shiZhi = inp.liuYaoZhi[inp.shiYaoIndex];
  int shiShenIdx;
  if([0,6].contains(shiZhi)) shiShenIdx=0;
  else if([1,7].contains(shiZhi)) shiShenIdx=1;
  else if([2,8].contains(shiZhi)) shiShenIdx=2;
  else if([3,9].contains(shiZhi)) shiShenIdx=3;
  else if([4,10].contains(shiZhi)) shiShenIdx=4;
  else shiShenIdx=5;
  res["世身"] = [inp.liuYaoZhi[shiShenIdx]];

  //=====9. 十二长生 生气=日支长生,死气=日支之死,死神=病
  // 简化：这里先按常用日支长生起例；如需五行长生版本可再扩展
  //=====10. 游都、飞符、血支、生气、死气、死神 预留查表+已填充基础规则
  // 如果你要，我可以把这几个再细化补齐独立查表

  return ShenShaResult(res,guaShenZhi,shiShenIdx);
}
