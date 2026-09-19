/// 爻的数据模型
class YaoModel {
  final int value; // 6:老阴 7:少阳 8:少阴 9:老阳
  final String selfGanZhi;
  final String selfQin;
  final String selfYaoName;
  final String? changedYaoName;
  final String liuShen;
  final String? shiYing;

  YaoModel({
    required this.value,
    required this.selfGanZhi,
    required this.selfQin,
    required this.selfYaoName,
    required this.liuShen,
    this.changedYaoName,
    this.shiYing,
  });

  bool get isYang => value == 7 || value == 9;
  bool get isChanging => value == 6 || value == 9;
}